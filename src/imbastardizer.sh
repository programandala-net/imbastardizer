#!/bin/sh

# imbastardizer.sh

# By Marcos Cruz (programandala.net), 2016, 2017.

# Command line wrapper for
# ~/.vim/plugins/imbastardizer.vim

# This file is part of Imbastardizer
# http://programandala.net/en.program.imbastardizer.html

# ==============================================================
# Usage

#   imbastardizer.sh infile [outfile]

# ==============================================================
# Change log

# 2016-12-14: Start.
# 2017-06-08: Update header.
# 2017-06-28: Improve comments.

# ==============================================================
# To-do

# Options for all the converter's config, and also:
# -v --version ('grep' the source)
#
# Use ':runtime' command instead of '-S' option.

# ==============================================================
# Error checking

if [ "$#" -gt 2 -o "$#" -eq 0 ] ; then
  echo "Convert an Imbastardizer source file to a target BASIC source"
  echo 'Usage:'
  echo "  ${0##*/} infile [outfile]"
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

# ==============================================================
# Main

# Vim options used:
# -e = Enter Vim in ex mode (in this case, the goal is just
#      preventing Vim from clearing the screen).
# -E = Enter Vim in improved ex mode (in this case, the goal is just
#      preventing Vim from clearing the screen).
# -n = No swap file will be used. This makes it possible
#      to convert a file currently open by other instance of Vim,
#      without the used to be asked for confirmation.
# -s = Silent mode (does not affect BAS2TAP messages).
# -S = Vim file to be sourced after the first file has been read.
# -c = Vim command to be executed after the first file has been read.

vim -E -n -S ~/.vim/imbastardizer.vim -c "call Imbastardizer('$2') | qall!" $1

# XXX FIXME -- Why Vim always return an exit code? This makes Makefile
# fail:
echo "Vim exit code: $?"
exit $?

# vim:tw=78:ts=2:sts=2:et:
