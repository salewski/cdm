#!/bin/bash -
# SPDX-FileCopyrightText: <text> © 2020 Alan D. Salewski <ads@salewski.email> </text>
# SPDX-License-Identifier: GPL-2.0-or-later

# cdm.bash: change to directory, creating it first if it does not yet exist.
#
# Since a subprocess cannot change the current working directory of a parent
# process, this script must be "sourced" in your current shell process to have
# the desired effect. To make that ergonomic, create a function such as the
# following in your ~/.bashrc:
#
#     function cdm () {
#         local impl_fpath="${HOME}/bin/cdm.bash"
#         if test -e "${impl_fpath}"; then :; else
#             printf "cdm: (error): no such file: %s; bailing out\n" "${impl_fpath}" 1>&2
#             return 1
#         fi
#     
#         source "${impl_fpath}" "$@"
#         return $?
#     }
#
#
# The 'cdm.bash' script effectively does this:
#
#     $ mkdir -p path/to/somedir
#     $ cd path/to/somedir
#
# Yes, this is done frequently enough that it merits its own wrapper script.
#
# CAVEAT: The '-h' (--help) and '-V' (--version) options are supported, but
#         not arbitrary command line opts. In particular, there is neither a
#         '-v' (--verbose) option nor support for the conventional '--'
#         pseudo-option. Hence, this script is unable to create directories
#         named in such a way that they look like command line opts. If you
#         need to do such things, you're probably using 'mkdir' directly,
#         anyway, so these limitations are not expected to be a problem in
#         practice.
#
# TODO:
#
#     * Maybe just do everything inside the 'cdm' shell function? That would
#       avoid souring this separate file.
#
#     * Maybe source 'cdm.bash' once during shell startup (for interactive
#       shells only). The function definition could be provided at that time,
#       which would make it more easily reusable.


# Our --help output and any error messages emitted will identify the program
# as 'cdm', not 'cdm.bash' (even though the latter is strictly speaking more
# correct). From the user's perspective, it is the 'cdm' tool that was
# invoked; producing any other name on the output is just needlessly leaking
# implementation details.
#
#declare __cdm_dot_bash_PROG='cdm.bash'
declare __cdm_dot_bash_PROG='cdm'

declare __cdm_dot_bash_COPYRIGHT_DATES='2020'

# # FIXME: one day this will be filtered in at build time
declare __cdm_dot_bash_MAINTAINER='Alan D. Salewski <ads@salewski.email>'

# # FIXME: one day this will be filtered in at build time
declare __cdm_dot_bash_VERSION='0.0.1'

# FIXME: one day this will be filtered in at build time
# This variable is replaced at build time
# declare -r gl_const_build_date='@BUILD_DATE@'
# declare -r gl_const_release="${VERSION}  (built: ${gl_const_build_date})"
declare __cdm_dot_bash_gl_const_release="${__cdm_dot_bash_VERSION}"


function __cdm_dot_bash_f_print_help () {

    cat <<EOF
usage: ${__cdm_dot_bash_PROG} { -h | --help }
  or:  ${__cdm_dot_bash_PROG} { -V | --version }
  or:  ${__cdm_dot_bash_PROG} DIRECTORY

Change (cd) to DIRECTORY, creating it first if it does not yet exist.
Any needed parent directories will be created, as well.

  -h, --help     Print this help message on stdout
  -V, --version  Print the version of the program on stdout

Report bugs to ${__cdm_dot_bash_MAINTAINER}.
EOF
}

__cdm_dot_bash_f_print_version () {
    cat <<EOF
${__cdm_dot_bash_PROG} ${__cdm_dot_bash_gl_const_release}

Copyright © ${__cdm_dot_bash_COPYRIGHT_DATES} Alan D. Salewski <ads@salewski.email>
License GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by Alan D. Salewski.
EOF
}

function __cdm_dot_bash_f_cleanup () {
    # In reverse order of their defs
    unset -f __cdm_dot_bash_f_print_version
    unset -f __cdm_dot_bash_f_print_help

    unset -v __cdm_dot_bash_target_directory

    unset -v __cdm_dot_bash_gl_const_release
    unset -v __cdm_dot_bash_VERSION
    unset -v __cdm_dot_bash_MAINTAINER
    unset -v __cdm_dot_bash_COPYRIGHT_DATES
    unset -v __cdm_dot_bash_PROG

    unset -f __cdm_dot_bash_f_cleanup  # self destruction
}

# Since this file is intended to be "sourced" into the user's current shell,
# we do not want want to introduce the machinery that would be required to do
# fully generic command line options parsing. But we do want to support the
# common case '--help' and '--version' usage; hence this compromise impl:

if test $# -lt 1; then
    printf "${__cdm_dot_bash_PROG} (error): DIRECTORY not specified; bailing out\n" 1>&2
    __cdm_dot_bash_f_print_help 1>&2
    __cdm_dot_bash_f_cleanup
    return 1
fi

case $1 in
    '-h' | '--help')
        # print help message
        __cdm_dot_bash_f_print_help
        __cdm_dot_bash_f_cleanup
        return 0
        ;;

    '-V' | '--version')
        # print help message
        __cdm_dot_bash_f_print_version
        __cdm_dot_bash_f_cleanup
        return 0
        ;;
    *)
        # fall through
        ;;
esac

if test $# -gt 1; then
    printf "${__cdm_dot_bash_PROG} (error): Only one DIRECTORY param may be specified; bailing out\n" 1>&2
    __cdm_dot_bash_f_print_help 1>&2
    __cdm_dot_bash_f_cleanup
    return 1
fi

__cdm_dot_bash_target_directory=$1
if test -z "${__cdm_dot_bash_target_directory}"; then
    printf "${__cdm_dot_bash_PROG} (error): Value provided for DIRECTORY may not be the empty string; bailing out\n" 1>&2
    __cdm_dot_bash_f_print_help 1>&2
    __cdm_dot_bash_f_cleanup
    return 1
fi
# XXX: The above just catches the simplest bogon case. In general, we'll
#      attempt to create whatever directory (or directories) the user has
#      requested. We are relying on the underlying mkdir(1) tool to reject all
#      invalid values.

if test -e "${__cdm_dot_bash_target_directory}"; then :; else
    declare -a __cdm_dot_bash_t_mkdir_opts=()
    __cdm_dot_bash_t_mkdir_opts+=('-p')  # --parents
    # if ${__cdm_dot_bash_BE_VERBOSE}; then
    #     __cdm_dot_bash_t_mkdir_opts+=('-v')  # --verbose
    # fi
    mkdir "${__cdm_dot_bash_t_mkdir_opts[@]}" "${__cdm_dot_bash_target_directory}"
    if test $? -ne 0; then
        printf "${__cdm_dot_bash_PROG} (error): Was error while creating \"%s\" (or one of its parent dirs); bailing out\n" \
               "${__cdm_dot_bash_target_directory}" 1>&2
        __cdm_dot_bash_f_cleanup
        return 1
    fi
fi

if test -e "${__cdm_dot_bash_target_directory}"; then
    if test -d "${__cdm_dot_bash_target_directory}"; then :; else
        printf "${__cdm_dot_bash_PROG} (error): \"%s\" exists, but is not a directory; bailing out\n" \
               "${__cdm_dot_bash_target_directory}" 1>&2
        __cdm_dot_bash_f_cleanup
        return 1
    fi
fi

# Avoid unsetting $CDPATH. If that was already set, then the user will
# reasonably expect that 'cdm' not interfere with it.
#
cd "${__cdm_dot_bash_target_directory}"
t_rtn=$?
__cdm_dot_bash_f_cleanup
return ${t_rtn}
