#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

for filename in $*
do
    if test -f $filename
    then
        more $filename
    else
        echo "$filename no es un fichero."
    fi
done