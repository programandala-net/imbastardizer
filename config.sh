# config.sh 

# By Marcos Cruz (programandala.net), 2016, 2017.

# This program configures the installation of Imbastardizer.
# Change it to suit your system.

# This file is part of Imbastardizer
# http://programandala.net/en.program.imbastardizer.html

# ==============================================================
# Change log

# 2016-12-14: First version.
# 2017-06-08: Update header.

# ==============================================================
# Installation directories

# Current user installation:

VIMDIR=~/.vim
BINDIR=~/bin

# System-wide installation:

#VIMDIR=/usr/share/vim/vimcurrent/
#BINDIR=/usr/local/bin

# ==============================================================
# Intallation command

# Create hard links:

INSTALLCMD="ln -f "

# Create symbolic links:

#INSTALLCMD="ln -s -f $(pwd)/"

# Copy the files:

# INSTALLCMD="cp -f -p "

