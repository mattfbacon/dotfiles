#!/bin/sh
latexmk -g -pdf -synctex=1 -shell-escape "${1:?need file}"
