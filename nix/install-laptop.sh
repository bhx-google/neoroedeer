#!/bin/bash

SCRIPT_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")

mkdir -p ~/.config/home-manager/
ln -sf $SCRIPT_DIR/home-laptop.nix ~/.config/home-manager/home.nix

