#!/bin/bash

command(){
  echo $1
  eval $1
}

if [ $# -lt 1 ]; then
  this=$(basename $0)
  echo "Usage: $this [path-to.c]"
else
  file=$1
  filename=${file%.*}

  command "gcc -nostdlib -fno-asynchronous-unwind-tables -c -o $filename.o $file"
  command "gobjcopy -O binary $filename.o $filename.bin"
  command "rm $filename.o"
  command "ndisasm -b 32 $filename.bin"
fi
