#!/bin/bash
re="\.txt$"
for file in ./*
do
if [[ -f $file && $file =~ $re ]]
then
echo "Match found: $file"
fi
done
