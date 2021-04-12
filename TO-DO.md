# Imbastardizer To-Do List

This file is part of
[Imbastardizer](http://programandala.net/en.program.imbastardizer.html).

By Marcos Cruz (programandala.net).

Last modified 20210412T1042+0200.

## Fix

- Check duplicated labels.
- Check all identifiers are matched at the start of the
  line or after a colon; this will prevent some mismatchs in
  text strings.
- Label definitions with uppercase letters are not
  recognized and removed.
- When `#filename X` is not at the left margin, the datum stored
  is part of `#filename`.

## Improve

- Make `silent` configurable in `#vim` substitutions.
- Error message if `#include` file is not found.
- Errors should be returned as exit status, in order to make
  things easier for 'make' and other tools. But how?
- Improve the command line wrapper with optional output file, after
  SBim.
- Save a step only if the buffer has changed.
- Parse all directives on one single pass, making `#define`, `#previm`, `#vim`
  and `#include` conditional.

## Add

- `#quiet` directive.
