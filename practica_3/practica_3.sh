#!/bin/bash
#839756, Vlasceanu, Andrei Gabriel, [M], [3], [A]
#842236, Yubero Segura, Andres, [M], [3], [A]

if test "$UID" -ne 0
then
    echo "Este script necesita permisos de administracion"
    exit 1
fi

echo "Eres privilegiadoooo"