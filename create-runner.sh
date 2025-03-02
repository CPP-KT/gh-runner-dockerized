#!/bin/bash

compiler=${1:?}
name=${2:-ubuntu-runner}-$compiler-$(openssl rand -hex 6)
echo $name

screen -S $name -d -m ./run.sh $compiler $name
