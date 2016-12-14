#!/bin/sh

# msximbas2bas.sh

# Command line wrapper for
# ~/.vim/plugins/msximbas2.vim

# By Marcos Cruz (programandala.net), 2016

# This file is part of MSX-imBASIC
# http://programandala.net/en.program.msx-imbasic.html

# ##############################################################
# Usage

#   msximbas2dsk.sh filename.msximbas

# ##############################################################
# History

# 2016-10-30: First version, based on <vbas2tap.sh>, from Vimclair
# BASIC (http://programandala.net/en.program.vimclair_basic.html).

# ##############################################################
# To-do

# Options for all the converter's config, and also:
# -v --version ('grep' the source)
#
# 2015-03-17: Use ':runtime' command instead of '-S' option.

# ##############################################################
# Error checking

if [ "$#" -ne 1 ] ; then
  echo "Convert an MSX-imBASIC source file to a MSX-BASIC program in a DSK disk image"
  echo 'Usage:'
  echo "  ${0##*/} sourcefile"
  exit 1
fi

if [ ! -e "$1"  ] ; then
  echo "<$1> does not exist"
  exit 1
fi

if [ ! -f "$1"  ] ; then
  echo "<$1> is not a regular file"
  exit 1
fi

if [ ! -r "$1"  ] ; then
  echo "<$1> can not be read"
  exit 1
fi

if [ ! -s "$1"  ] ; then
  echo "<$1> is empty"
  exit 1
fi

# ##############################################################
# Main

# Vim options used:
# -e = Enter Vim in ex mode (in this case, the goal is just
#      preventing Vim from clearing the screen).
# -n = No swap file will be used. This makes it possible
#      to convert a file currently open by other instance of Vim,
#      without the used to be asked for confirmation.
# -s = Silent mode (does not affect BAS2TAP messages).
# -S = Vim file to be sourced after the first file has been read.
# -c = Vim command to be executed after the first file has been read.

vim -e -n -S ~/.vim/msximbas2.vim -c "call MSXimbas2bas() | q!" $1

# XXX FIXME -- Why does Vim return exit code 1:
#echo "Vim ouput code is $?"

# exit?

# XXX TMP --
exit 0

# vim:tw=78:ts=2:sts=2:et:

