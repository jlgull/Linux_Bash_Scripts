#!/bin/bash

function Dec2Bin
{
        local i; local j; Binary=

        for (( i=$1; i>0; i>>=1 ))
        do
                j="$((i&1))$j"
        done

        printf -v Binary "%016d" $j
}

Result=0

echo
read -p "Input first number : " Input1; Dec2Bin $Input1; Number1=$Binary
read -p "Input second number: " Input2; Dec2Bin $Input2; Number2=$Binary
echo "The first number, in binary, is : "$Number1"   (Decimal "$Input1")"
echo "The second number, in binary, is: "$Number2"   (Decimal "$Input2")"

Result=$((Input1&Input2)); Dec2Bin $Result; Number3=$Binary
echo "ANDing the two numbers gives    : "$Number3"   (Decimal "$Result")"