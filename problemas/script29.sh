#!/bin/bash

input_file=$1
output_file=$2

awk '!seen[$0]++' "$input_file" > "$output_file"
