#!/bin/bash

# determine name of organization 
echo -n "Enter the 'string' you want to decrypt : "
read -a input
echo ""

echo "$input" | openssl enc -base64 -d

echo ""
echo "complete."
