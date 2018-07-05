/*******************************************************************************
 *
 * Copyright (c) Projet S6, �quipe P4
 *
 ******************************************************************************/

/**
 * @file Fuses.c
 * @brief Contains the fuses configurations for the ATmega256RFR2.
 */

#include <avr/io.h>
#include <avr/fuse.h>

FUSES = {
    .low = (FUSE_CKSEL_SUT0 & FUSE_CKSEL_SUT2 & FUSE_CKSEL_SUT3 &
            FUSE_CKSEL_SUT4),
    .high = HFUSE_DEFAULT,
    .extended = EFUSE_DEFAULT,
};
