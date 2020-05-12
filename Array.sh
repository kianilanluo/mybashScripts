#!/bin/sh
#
# 5/1/2017
#
echo "script7 - Linux Scripting Book"
array_var=(1 2 3 4 5 6)
echo "List all elements (alternative method):"
echo ${array_var[@]}
echo "Number of elements: ${#array_var[*]}"
labip[0]="192.168.1.1"
labip[1]="192.168.1.10"
labip[2]="192.168.1.15"
labip[3]="192.168.1.16"
labip[4]="192.168.1.20"
echo ${labip[0]}
echo ${labip[1]}
echo ${labip[2]}
echo ${labip[3]}
echo ${labip[4]}
echo "List all elements:"
echo ${labip[*]}
echo "Number of elements: ${#labip[*]}"
echo "End of script7"
