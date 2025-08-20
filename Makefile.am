## Process this file with automake to produce Makefile.in -*-Makefile-*-

## SPDX-FileCopyrightText: <text>
##     © 2016, 2020, 2025 Alan D. Salewski <ads@salewski.email>
## </text>
## SPDX-License-Identifier: GPL-2.0-or-later

SUBDIRS = src \
          .

# The ACLOCAL_AMFLAGS are used by 'autoreconf' and by the Makefile rebuild
# rule when they need to run 'aclocal'.
#
ACLOCAL_AMFLAGS = -I autotools


## Ensure that these files make it into the distribution tarball
##
EXTRA_DIST = BUGS HACKING

MAINTAINERCLEANFILES = config.status \
                       config.log    \
                       $(PACKAGE)-$(VERSION).tar.gz \
                       *~
