#!/bin/zsh

export cloudHome="/google/src/cloud/$USER"

# Workspace name
function workspace() {
  # Use :A parameter expansion to resolve symlinks to /google/src
  # http://zsh.sourceforge.net/Doc/Release/Expansion.html#index-parameter-expansion-flags
  if [[ $1:A =~ "$cloudHome/([^/]+)" ]]; then
    echo ${match[1]}
  fi
}

# Absolute directory of our workspace
function workspace_dir() {
  if [[ $WORKSPACE != "" ]]; then
    echo "$cloudHome/$WORKSPACE/google3"
  fi
}

# Relative path after google3/
function source_pwd() {
  local wkspace_dir=$(workspace_dir)
  if [[ -n "$wkspace_dir" ]]; then
    echo "$PWD[${#wkspace_dir}+2,${#PWD}]"
  fi
}

function get_window_name() {
  local name=$(workspace $1)
  if [[ -z $name ]]; then
      echo $(basename $1)
  else
      echo "W:$name"
  fi
}
