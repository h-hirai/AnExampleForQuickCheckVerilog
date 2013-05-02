#! /bin/bash

CC=ghc
LD=ghc
MODELSIM_HOME="$(cygpath -m /cygdrive/c/altera/12.1sp1/modelsim_ase)"

./clean.sh

vlib work
vlog -sv -dpiheader dpiheader.h test_accum.v accum.v
vsim -dpiexportobj exportobj test_accum
${CC} -c hsMain.hs
${CC} -c -I"${MODELSIM_HOME}/include" c_main.c
${LD} -shared -L$"${MODELSIM_HOME}/win32aloem" -o main.dll exportobj.obj c_main.o hsMain.o -lmtipli -package QuickCheck
