#!/bin/sh

# install.sh

# This file is part of fsb
# http://programandala.net

# ##############################################################
# Author and license

# Copyright (C) 2016 Marcos Cruz (programandala.net)

# You may do whatever you want with this work, so long as you
# retain the copyright notice(s) and this license in all
# redistributed copies and derived works. There is no warranty.

# ##############################################################
# Description

# This program installs Imbastardizer.
#
# Edit <config.sh> first to suit your system.

# ##############################################################
# Usage

#   install.sh

# ##############################################################
# History

# 2016-12-14: First version.

# ##############################################################

. ./CONFIG.sh

eval ${INSTALLCMD}imbastardizer.vim $VIMDIR/imbastardizer.vim
eval ${INSTALLCMD}ftdetect/imbastardizer.vim $VIMDIR/ftdetect/imbastardizer.vim
eval ${INSTALLCMD}ftplugin/imbastardizer.vim $VIMDIR/ftplugin/imbastardizer.vim

eval ${INSTALLCMD}imbastardizer.sh $BINDIR/imbastardizer
