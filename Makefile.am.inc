## -*-Makefile-*-
## SPDX-FileCopyrightText: <text>
##     © 2025 Alan D. Salewski <ads@salewski.email>
## </text>
## SPDX-License-Identifier: GPL-2.0-or-later
##
## This file, Makefile.am.inc, is a fragment of a Makefile.am file, which is
## suitable for inclusion in any or all of this project's 'Makefile.am' files,
## via something like this:
##
##     include $(top_srcdir)/Makefile.am.inc
##
## Note that that 'inlcude' statement is an Automake directive.

## We centralize the definition of 'dotbashdir' here, which makes it possible
## to declare, for example, 'dotbash_DATA = whatever' in directory-specific
## Makefile.am files.
##
# Location into which we will install our Bash-specific data files.
dotbashdir = $(pkgdatadir)/bash
