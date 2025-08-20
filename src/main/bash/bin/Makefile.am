## Process this file with automake to produce Makefile.in   -*-Makefile-*-

## SPDX-FileCopyrightText: <text>
##     © 2016, 2020, 2025 Alan D. Salewski <ads@salewski.email>
## </text>
## SPDX-License-Identifier: GPL-2.0-or-later

# Pull in centralized definition of dotbashdir, the location into which we
# will install our Bash-specific data files.
#
include $(top_srcdir)/Makefile.am.inc

#SUBDIRS =  \
#          .

INPUT_TEMPLATES = \
    cdm-generate.in

# "static" scripts
SSCRIPTS =
# "generated" scripts (filtered here by do_subst)
#GSCRIPTS = $(INPUT_TEMPLATES:.in=-$(VERSION))
GSCRIPTS = $(INPUT_TEMPLATES:.in=)


# "static" section 1 man pages
S1MANPAGES =
# "generated" section 1 man pages
#G1MANPAGES = $(INPUT_TEMPLATES:.in=.1)
G1MANPAGES =


bin_SCRIPTS = $(SSCRIPTS) $(GSCRIPTS)

dist_noinst_DATA = $(INPUT_TEMPLATES)


man1_MANS = $(S1MANPAGES) $(G1MANPAGES)

CLEANFILES = $(GSCRIPTS) $(G1MANPAGES)

@do_subst_command@

# Command for sed sanitizing the value of a var for use on the left side of a
# sed 's' (substitution) command.
#
@sed_slsanitize_command@


# Generated scripts depend on Makefile so they will be rebuilt if $(VERSION)
# or other do_subst'ituted variables change.
#
$(GSCRIPTS): Makefile


# Rule to build non-versioned scripts from corresponding non-versioned input
# templates.
#
# Uses chmod a-w to prevent people from editing the wrong file by accident.
#
# Note that the script depends on the naming convention:
#
# Target:
#
#     <PROG_NAME_BASE>
#
# is generated from:
#
#     <PROG_NAME_BASE>.in
#
$(GSCRIPTS): %: %.in
	$(AM_V_GEN)set -e ;\
	"$(RM)" -f "$@" "$@.tmp" ;\
	_t_base="$@"        ;\
	$(do_subst) "$(srcdir)/$${_t_base}.in" > "$@.tmp" ;\
	"$(MV_PROG)" "$@.tmp" "$@"    ;\
	"$(CHMOD_PROG)" a-w "$@"      ;\
	"$(CHMOD_PROG)" a+rx "$@"
