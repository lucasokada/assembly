#!/bin/bash

program=$1

nasm -f elf $program
echo "processo finalizado"
