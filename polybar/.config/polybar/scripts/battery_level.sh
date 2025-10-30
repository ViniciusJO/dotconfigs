#!/usr/bin/env sh

acpi | awk '{print $4}' | cut -d',' -f1 | cut -d'%' -f1
