# Imbastardizer

<!--
Last modified 20210408T1918+0200.
-->

## Description

Imbastardizer is a source preprocessor, especially suited for old or
limited dialects of BASIC.

It's written in [Vim Script](http://www.vim.org).

- [Homepage](http://programandala.net/en.program.imbastardizer.html).
- [Repository](http://fossil.programandala.net/imbastardizer).

## Features

Planned for version 1.0.0:

* Splitted lines.
* Labels instead of line numbers.
* Shell-style line comments.
* `#define`, `#ifdef`, `#ifndef` directives.
* `#vim` directive to execute any Vim command in the source.

The previous version 0.4.2 had many more features and a different
approach.

## Status

At the time of writing (2021-04) Imbastardizer is being rewritten to
prepare version 1.0.0.

## History 

Imbastardizer started in 2016-12, as an improved replacement for
previous tools developed by the author for one specific dialect of
BASIC:

- [BBim](http://programandala.net/es.programa.bbim.html) for Beta
  BASIC (ZX Spectrum)
- [MBim](http://programandala.net/en.program.mbim.html) for
  MasterBASIC (SAM Coupé)
- [SBim](http://programandala.net/es.programa.sbim.html) for S*BASIC
  (Sinclair QL or SMSQ/E)
- [Vimclair
  BASIC](http://programandala.net/en.program.vimclair_basic.html) for
  Sinclair BASIC (ZX Spectrum)

The goal of Imbastardizer was to replace them all and select the
target with a directive. Anyway, the initial targets were new:
GW-BASIC and MSX-BASIC.

The supported features were the following:

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

In 2016-12..2017-07 Imbastardizer was heavily tested during the
development of the [CE4 project in
GW-BASIC](http://fossil.programandala.net/ce4/timeline?r=imbastardizer)
for the [PC-BASIC emulator](http://pc-basic.org).

Then the CE4 project changed its target platform and the development
of Imbastardizer stagned. Besides, although it worked great, extending
some features, especially the control structures and the
pseudo-procedures, to support more target dialects of BASIC seemed too
complex for the small benefit.

In 2021-04 the need for a generic but simpler source preprocessor
arised during the development of the [CE4 project in
NextBASIC](http://fossil.programandala.net/ce4/timeline?r=nextbasic),
and rewritting Imbastardizer with a new approach seemed the best
option.

In order to resume the development of Imbastardizer, its Git
repository was converted to [Fossil](http://fossil-scm.org), but
keeping [GitHub as a
mirror](http://github.com/programandala-net/imbastardizer). The latest
version was tagged as v0.4.2.
