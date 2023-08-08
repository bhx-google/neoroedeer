#!/bin/zsh

local script_dir=`dirname $0`
source $script_dir/piper_helper.sh

echo $(get_window_name $1)
