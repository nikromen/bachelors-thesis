#!/bin/bash


if [ $(git status --porcelain thesis/ | wc -l) -ne "0" ]; then
    git add thesis/;
    git commit -m "overleaf: auto rebase from overloaf";
    git push;
fi
