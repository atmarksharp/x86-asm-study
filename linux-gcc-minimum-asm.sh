#!/bin/bash

command(){
  echo $1
  eval $1
}

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

  command "gcc -Wl,$ld_flags--oformat=binary -nostdlib -fno-asynchronous-unwind-tables -o $filename.bin $file"
  command "ndisasm -b 32 $filename.bin"
fi
