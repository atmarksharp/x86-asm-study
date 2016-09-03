#!/bin/bash

if [ $# -lt 1 ]; then
  this=$(basename $0)
  echo "Usage: $this [path-to.c] ([entry-func])"
else
  file=$1
  filename=${file%.*}

  if [ $# -gt 1 ]; then
    ld_flags="--entry=$2,"
  else
    ld_flags=""
  fi

  cmd="gcc -Wl,$ld_flags--oformat=binary -nostdlib -fno-asynchronous-unwind-tables -o $filename.bin $file"
  echo $cmd
  eval $cmd
fi
