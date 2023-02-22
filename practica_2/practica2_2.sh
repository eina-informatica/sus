#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

for FILENAME in $*
do
    if test -f $FILENAME
    then
        more $FILENAME
    else
        echo "$FILENAME no es un fichero."
    fi
done