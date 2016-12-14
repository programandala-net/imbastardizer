# config.sh 

# This file is part of Imbastardizer
# http://programandala.net

# ##############################################################
# Author and license

# Copyright (C) 2016 Marcos Cruz (programandala.net)

# You may do whatever you want with this work, so long as you
# retain the copyright notice(s) and this license in all
# redistributed copies and derived works. There is no warranty.

# ##############################################################
# Description

# This program configures the installation of Imbastardizer.
#
# Change it to suit your system.

# ##############################################################
# History

# 2016-12-14: First version.

# ##############################################################
# Installation directories

# Current user installation:

VIMDIR=~/.vim
BINDIR=~/bin

# System-wide installation:

#VIMDIR=/usr/share/vim/vimcurrent/
#BINDIR=/usr/local/bin

# ##############################################################
# Intallation command

# Create hard links:

INSTALLCMD="ln -f "

# Create symbolic links:

#INSTALLCMD="ln -s -f $(pwd)/"

# Copy the files:

# INSTALLCMD="cp -f -p "

