#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

mkdir -p ~/.config/nixpkgs/
ln -sf $SCRIPT_DIR/home.nix /usr/local/google/home/bhx/.config/home-manager/home.nix

