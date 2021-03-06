/*******************************************************************************
 *
 * Copyright (c) Projet S6, Équipe P4
 *
 ******************************************************************************/

/**
 * @file SPI.c
 * @brief Implements the functions for using the SPI bus on the ATmega256RFR2
 */

#include <avr/io.h>

#include <assert.h>

#include "SPI.h"

void SpiInitMaster(void)
{
    // Ports directions
    DDRB |= _BV(2);  // Set MOSI as output
    DDRB |= _BV(1);  // Set SCK as output
    DDRB &= ~_BV(3); // Set MISO as input
    DDRD |= _BV(6);  // Set SS as output

    PORTD |= _BV(6); // Set SS to high

    // SPI control register
    SPCR = 0x00;             // Disable and reset the SPI peripheral
    SPCR |= _BV(4);          // Put SPI in master mode
    SPCR |= _BV(3) | _BV(2); // CPOL = 1, CPHA = 1 (SPI mode 3)
    SPCR |= _BV(0);          // SCK = Fosc/16

    SPSR |= _BV(0);          // Doubles SPI clock frequency

    uint8_t dummy = SPSR;    // Clear the interrupts of the peripheral
    dummy = SPDR;            // Clear the last value on the peripheral
}

void SpiBeginTransfer(void)
{
    SPCR |= _BV(6);   // Enable SPI peripheral
    PORTD &= ~_BV(6); // Set SS to low
}

void SpiEndTransfer(void)
{
    PORTD |= _BV(6); // Set SS to high
    SPCR &= ~_BV(6); // Disable SPI peripheral
}

void SpiWriteByte(uint8_t byte)
{
    SPDR = byte;
    while(!(SPSR & (1 << SPIF)))
    {
        ; // Wait for transfer to complete
    }
}

uint8_t SpiReadByte(void)
{
    assert(SPSR & (1 << SPIF)); // Make sure there is data to be read
    return SPDR;
}
