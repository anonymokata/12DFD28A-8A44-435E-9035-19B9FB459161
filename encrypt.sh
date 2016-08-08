#!/bin/bash


# determine name of organization 
echo -n "Enter the 'string' you want to encrypt : "
read -a input
echo ""

echo "$input" | openssl enc -base64

echo ""
echo "complete."
