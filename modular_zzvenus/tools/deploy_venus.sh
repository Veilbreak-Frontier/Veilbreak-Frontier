#!/bin/bash

# This script will deploy our Venus-specific modular icon assets so iconforge can use them in spritesheet generation
# This includes modular_zzvenus/icons

mkdir -p \
    $1/modular_zzvenus/icons

cp -r modular_zzvenus/icons/* $1/modular_zzvenus/icons/
