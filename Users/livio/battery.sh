#! /bin/bash

pmset -g batt | sed '1 d' | awk '{print $2}' | sed 's/;*$//'
