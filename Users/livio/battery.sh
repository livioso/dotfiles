#! /bin/bash

pmset -g batt | sed '1 d' | awk '{print $3}' | sed 's/;*$//'
