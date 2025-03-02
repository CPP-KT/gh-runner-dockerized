#!/bin/bash

name=${1:-ubuntu-runner}-$(openssl rand -hex 6)
echo $name

screen -S $name -d -m ./run.sh $name
