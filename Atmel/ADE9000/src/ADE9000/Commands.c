/*******************************************************************************
 *
 * Copyright (c) Projet S6, Équipe P4
 *
 ******************************************************************************/

/**
 * @file Commands.c
 * @brief Implements ADE9000/Commands.h for the ATmega256RFR2.
 */

#include <stdint.h>
#include <assert.h>

#include <avr/io.h>

#include "SPI.h"

#include "ADE9000/Addresses.h"
#include "ADE9000/Commands.h"

// 16-bit type punning union
typedef uint8_t TwoBytesArray_t[2];
typedef union {
    uint16_t uint16;
    TwoBytesArray_t uint8_ptr;
} TwoBytes_t;

// 32-bit type punning union
typedef uint8_t FourBytesArray_t[4];
typedef union {
    uint32_t uint32;
    FourBytesArray_t uint8_ptr;
} FourBytes_t;

static const uint16_t ENABLE_DSP = 0x0001;

// ADE9000 PF and THD multiplication factor from Q5.27 to float
static const float CONV_PF_THD = 0.000000007450580597f; // 2^-27
// ADE9000 division factor for obtaining the full scale RMS values
static const float FULL_SCALE_RMS = 52702092.0f;

float getTHD(void)
{
    const float rawRead = (float)ADE9000Read32(ADDR_AVTHD);
    return rawRead * CONV_PF_THD * 100.0f;
}

float getPF(void)
{
    // cast to int because PF is in signed Q5.27
    const int32_t rawRead = (int32_t)ADE9000Read32(ADDR_APF);
    return (float)rawRead * CONV_PF_THD;
}

float getVrms(void)
{
    const float V_NOMINAL = 120.0f; // Multiplication factor 1V to 120V
    const float V_CORR = 1.188f;    // Normalizing factor for the 10uf cap
    const float rawRead = (float)ADE9000Read32(ADDR_AVRMS);
    return rawRead / FULL_SCALE_RMS * V_NOMINAL * V_CORR;
}

float getIrms(void)
{
    const float I_NOMINAL = 5.0f; // Multiplication factor 1A to 5A
    const float I_CORR = 1.1f;    // Normalizing factor for the 10uF cap
    const float rawRead = (float)ADE9000Read32(ADDR_AIRMS);
    return rawRead / FULL_SCALE_RMS * I_NOMINAL * I_CORR;
}

void ADE9000Write(uint16_t address, size_t n, const uint8_t* data)
{
    // Precondition
    assert(address <= 0xFFF);

    // Send address MSB first
    uint8_t address_high = (address >> 4);
    uint8_t address_low = (address << 4) & 0xF7; // Reset the address read bit

    SpiBeginTransfer();

    SpiWriteByte(address_high);
    SpiWriteByte(address_low);

    // Write MSB first
    while(n--)
    {
        SpiWriteByte(data[n]);
    }

    SpiEndTransfer();
}

void ADE9000Write16(uint16_t address, uint16_t data)
{
    TwoBytes_t buffer = {.uint16 = data};
    ADE9000Write(address, 2, buffer.uint8_ptr);
}

void ADE9000Write32(uint16_t address, uint32_t data)
{
    FourBytes_t buffer = {.uint32 = data};
    ADE9000Write(address, 4, buffer.uint8_ptr);
}

void ADE9000Read(uint16_t address, size_t n, uint8_t* data)
{
    // Precondition
    assert(address <= 0xFFF);

    // Send address MSB first
    uint8_t address_high = (address >> 4);
    uint8_t address_low = ((address << 4) | 0x08); // Set the address read bit

    SpiBeginTransfer();

    SpiWriteByte(address_high);
    SpiWriteByte(address_low);

    // Read MSB first
    while(n--)
    {
        SpiWriteByte(0x00); // dummy write
        data[n] = SpiReadByte();
    }

    SpiEndTransfer();
}

uint16_t ADE9000Read16(uint16_t address)
{
    TwoBytes_t buffer;
    ADE9000Read(address, 2, buffer.uint8_ptr);
    return buffer.uint16;
}

uint32_t ADE9000Read32(uint16_t address)
{
    FourBytes_t buffer;
    ADE9000Read(address, 4, buffer.uint8_ptr);
    return buffer.uint32;
}

void ADE9000Setup(void)
{
    // Verify the connection to the ADE9000
    // uint32_t partID = ADE9000Read32(ADDR_PART_ID);
    // assert((partID >> 20) & 1);

    // Configure the ADE9000 for 60Hz
    ADE9000Write16(ADDR_ACCMODE, ADE9000Read16(ADDR_ACCMODE) | 0x0100);
    // Configure nominal VLEVEL to 1Vp
    ADE9000Write32(ADDR_VLEVEL, 0x00117514);
    // Disable no load threshold timer
    ADE9000Write16(ADDR_EP_CFG, ADE9000Read16(ADDR_EP_CFG) | 0xE000);
    // Set phase A as reference for phase measurements
    ADE9000Write16(ADDR_ZX_LP_SEL, ADE9000Read16(ADDR_ZX_LP_SEL) & 0xFFC1);
    // Enable measurements
    ADE9000Write16(ADDR_RUN, ENABLE_DSP);
    // Enable power accumulation
    ADE9000Write16(ADDR_EP_CFG, ADE9000Read16(ADDR_EP_CFG) | 0x0001);
}
