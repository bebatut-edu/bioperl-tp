#!/usr/bin/env bash

pandoc -s protocol.md \
    -t latex \
    -o sujet.pdf \
    --filter pandoc-fignos \
    --bibliography=references.bib \
    --csl=apa.csl \