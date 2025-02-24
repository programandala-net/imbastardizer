# Imbastardizer

<!--
Last modified 20250224T1842+0100.
-->

## Description

Imbastardizer is a source preprocessor for old dialects of BASIC.

Imbastardizer is written in Vimscript and can be executed on
[Vim](https://www.vim.org) and [Neovim](https://neovim.io).

* [Homepage](http://programandala.net/en.program.imbastardizer.html)
* [Repository on SourceHut](https://hg.sr.ht/~programandala_net/imbastardizer)
* [Mirror repository on GitHub](http://github.com/programandala-net/imbastardizer).

## Motivation and history

Imbastardizer started in 2016-12 as an improved replacement for previous tools
developed by the author for some dialects of BASIC:

* [BBim](http://programandala.net/es.programa.bbim.html) for Beta BASIC (ZX
  Spectrum)
* [MBim](http://programandala.net/en.program.mbim.html) for MasterBASIC (SAM
  Coupé)
* [SBim](http://programandala.net/es.programa.sbim.html) for SuperBASIC
  (Sinclair QL's QDOS) and SBASIC (SMSQ/E)
* [Vimclair BASIC](http://programandala.net/en.program.vimclair_basic.html) for
  Sinclair BASIC (ZX Spectrum)

The goal of Imbastardizer was to replace them all and select the target with a
directive. Nevertheless, the initial targets were GW-BASIC and MSX-BASIC.

In 2016-12/2017-07 Imbastardizer was heavily tested during the development of a
GW-BASIC text-based game for the [PC-BASIC emulator](http://pc-basic.org). When
the project changed its target platform the development of Imbastardizer
stagned. Besides, although it worked great, extending some features, especially
the control structures and the pseudo-procedures, to support more target
dialects of BASIC seemed too complex for the small benefit.

In 2021-04 the need for a generic but simpler source preprocessor arised during
the development of a project in ZX Spectrum Next's NextBASIC, and rewritting
Imbastardizer with a new, much simpler approach before version 1.0.0 seemed the
best option. Finally Imbastardizer became unnecessary and was abandoned.

## Features

### Version 0.4.2

* C-style block and line comments.
* Shell-style line comments.
* Splitted lines.
* Labels instead of line numbers.
* `#vim` directive to execute any Vim command in the source.
* `#include`, `#define`, `#ifdef`, `#ifndef` and others.
* Long variable names using the `#vim` directive to make the
  substitutions.
* Control structures (can be nested):
  * `DO ... LOOP`
  * `DO ... LOOP UNTIL`
  * `DO ... LOOP WHILE`
  * `DO UNTIL... LOOP`
  * `DO UNTIL ... LOOP UNTIL`
  * `DO UNTIL ... LOOP WHILE`
  * `DO WHILE ... LOOP`
  * `DO WHILE ... LOOP UNTIL`
  * `DO WHILE ... LOOP WHILE`
  * `EXIT DO`
  * `EXIT FOR`
  * `IF ... THEN ... ENDIF`
  * `IF ... THEN ... ELSE ... ENDIF`
  * `IF ... THEN ... ELSE IF ... ELSE ... ENDIF` (with any number of
    `ELSE IF`)
* Procedures (without parameters): `DEF PROC`, `END PROC`, `EXIT
  PROC`, `CALL`.
* Procedures with parameters can be simulated ad hoc with the `#vim`
  directive.
* The `CALL` command can be changed with `#procedureCall`, e.g.:
  `#procedureCall proc` or even make it empty: `#procedureCall`.

### Unfinished version 1.0.0

* Labels instead of line numbers.
* `#define`.
* `#include`.

## Installation and usage

To install Imbastardizer, copy "imbastardizer.vim" to the "~/.vim" directory.
Then the program can be executed with Vim's `runtime` command.

Example of a "Makefile" rule that preprocess a BASIC source file with
Imbastardizer:

```
src/%.bas: target/%.bas
	@vim -e -R \
		-c "runtime imbastardizer.vim" \
		-c "saveas! $@|q!" $<

```

## Repository

* 2021-04-08: the Git repository was converted to
  [Fossil](https://fossil-scm.org), but keeping [GitHub as a
  mirror](http://github.com/programandala-net/imbastardizer).
* 2023-04-05: the Fossil repository was converted to
  [Mercurial](https://mercurial-scm.org), enabling better interaction with
  GitHub.
* 2025-02-23: the Mercurial repository was uploaded to
  [SourceHut](https://hg.sr.ht/~programandala_net/imbastardizer), keeping
  GitHub as a mirror.
