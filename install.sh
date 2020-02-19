#!/bin/sh

# install.sh

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

. ./config.sh

eval ${INSTALLCMD}src/vim/ftdetect/imbastardizer.vim $VIMDIR/ftdetect/
eval ${INSTALLCMD}src/vim/ftplugin/imbastardizer.vim $VIMDIR/ftplugin/
eval ${INSTALLCMD}src/vim/syntax/gwbasic.vim $VIMDIR/syntax/
eval ${INSTALLCMD}src/vim/syntax/imbastardizer.vim $VIMDIR/syntax/
eval ${INSTALLCMD}src/vim/syntax/msxbasic.vim $VIMDIR/syntax/

eval ${INSTALLCMD}src/vim/imbastardizer.vim $VIMDIR/
eval ${INSTALLCMD}src/vim/imbastardizer_version.vim $VIMDIR/

eval ${INSTALLCMD}src/imbastardizer.sh $BINDIR/imbastardizer
