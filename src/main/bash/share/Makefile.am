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
    cdm.bash.in   \
    cdm_function.bash.in

# "static" data flies
SDATAS =

# "generated" data files (filtered here by do_subst)
GDATAS = $(INPUT_TEMPLATES:.in=)

dotbash_DATA = $(SDATAS) $(GDATAS)

dist_noinst_DATA = $(INPUT_TEMPLATES)


CLEANFILES = $(GDATAS)

@do_subst_command@

# Command for sed sanitizing the value of a var for use on the left side of a
# sed 's' (substitution) command.
#
@sed_slsanitize_command@


# Generated data files depend on Makefile so they will be rebuilt if
# $(VERSION) or other do_subst'ituted variables change.
#
$(GDATAS): Makefile


# Rule to build non-versioned data files from corresponding non-versioned
# input templates.
#
# Uses chmod a-w to prevent people from editing the wrong file by accident.
#
# Note that the script depends on the naming convention:
#
# Target:
#
#     <DATA_FILE_NAME_BASE>
#
# is generated from:
#
#     <DATA_FILE_NAME_BASE>.in
#
$(GDATAS): %: %.in
	$(AM_V_GEN)set -e ;\
	"$(RM)" -f "$@" "$@.tmp" ;\
	_t_base="$@"        ;\
	$(do_subst) "$(srcdir)/$${_t_base}.in" > "$@.tmp" ;\
	"$(MV_PROG)" "$@.tmp" "$@"  ;\
	"$(CHMOD_PROG)" a-wr "$@"   ;\
	"$(CHMOD_PROG)" a+r "$@"
