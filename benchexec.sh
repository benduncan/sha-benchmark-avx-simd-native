#!/bin/bash

args=("$@")
END=${args[1]}
START=1

for (( c=$START; c<=$END; c++ ))
do
	${args[0]}
done
