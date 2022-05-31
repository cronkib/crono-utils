#!/bin/bash
#
# Notes: 
#     - Bash 4 is required for associative arrays.
# 
FANCY_TEMPLATE="\e[STYLECOLORmVALUE\e[0m"

declare -A colors=( 
    ["red"]=";31" 
    ["green"]=";32"
    ["yellow"]=";33"
    ["blue"]=";34"
    ["magenta"]=";35"
    ["cyan"]=";36"
    ["gray"]=";37"
    ["none"]=""
)

declare -A styles=(
    ["normal"]="0"
    ["bold"]="1"
    ["underline"]="4"
    ["reverse"]="7"
)

fancy_print() {
    if [ "$#" -eq 3 ]; then
        style="${styles[$1]}"
        color="${colors[$2]}"
        value=$3
    elif [ "$#" -eq 2 ]; then
        style="${styles[$1]}"
        color="${colors[none]}"

        if [ -z "$style" ]; then
            style="${styles[normal]}"
            color="${colors[$1]}"
        fi

        value=$2
    elif [ "$#" -eq 1 ]; then
        style="${styles[normal]}"
        color="${colors[none]}"
        value=$1
    fi

    if [ -z $style ] && [ -z $color ] && [ -z $value ]; then
        fancy_print_help
        return 1
    fi

    fancy="${FANCY_TEMPLATE//STYLE/$style}"
    fancy="${fancy//COLOR/$color}"
    fancy="${fancy//VALUE/$value}"

    echo -en "$fancy"
}

fancy_println() {
    fancy=$(fancy_print $@)
    echo -e "$fancy"
}
