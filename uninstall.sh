#!/bin/sh

# uninstall.sh

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

# This program uninstalls Imbastardizer.
#
# Edit <config.sh> first to suit your system.

# ##############################################################
# Usage

#   uninstall.sh

# ##############################################################
# History

# 2016-12-14: First version.

# ##############################################################

. ./CONFIG.sh

rm -f $VIMDIR/imbastardizer.vim
rm -f $VIMDIR/ftdetect/imbastardizer.vim
rm -f $VIMDIR/ftplugin/imbastardizer.vim
rm -f $BINDIR/imbastardizer
