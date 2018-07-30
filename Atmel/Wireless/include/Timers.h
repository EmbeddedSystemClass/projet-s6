/*******************************************************************************
 *
 * Copyright (c) Projet S6, �quipe P4
 *
 ******************************************************************************/

#pragma once

#include <stdbool.h>

void setupWirelessTimers(void);

void resetWirelessTimers(void);

bool checkSendDataTimer(void);

bool checkAckTimer(void);