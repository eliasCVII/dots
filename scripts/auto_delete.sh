#!/bin/env bash
# $1 = filename, $2 = y/n to delete the residual pdf files

found=0

function check(){
  if ls "pdf/$1".* 1> /dev/null 2>&1; then
    found=1
  fi
}

function delete_all(){
  if [ $found -eq 1 ]; then
    echo "removing all residual files"
    rm "pdf/$1".*
  else
    echo 'no files to remove in pdf/'
  fi
}

if [ -z $2 ]; then
  echo "keeping pdf/ files"
  yes | python manage.py remove_note $1
elif [ $2 == "y" ]; then
  check $1
  delete_all $1
fi
