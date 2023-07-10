#!/usr/bin/env Rscript

packages = commandArgs(trailingOnly=TRUE)

for (l in packages) {
    if ( ! library(l, character.only=TRUE, logical.return=TRUE) ) {
        quit(status=1, save='no')
    }
}
