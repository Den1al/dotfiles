#!/bin/bash

# Remove existing symlinks
stow --delete .

# Stow will fail if real files exist in target - that's expected
# Run with -v to see what's happening
stow . -v
