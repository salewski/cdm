# cdm

# Overview

This is the README.md file for the `'cdm'` project.

The (tiny) `'cdm'` project simply provides some machinery for a Unix-style
shell (currently only for Bash, but patches to support other shells would be
welcome) that makes it easy to perform the extremely common task of creating a
directory (with `mkdir(1)`) and then immediately changing into it (with `cd`).

Yes, this is done frequently enough that it merits its own wrapper script.

The reason the two-step sequence of commands (`mkdir` followed by `cd`)
requires "machinery" is that on Unix-like operating systems, a sub-process
cannot affect the "current working directory" of the parent process. Hence, if
we want a shell command to change the current directory of "this" shell
process, our options for doing so include:

   1. define a shell alias
   2. define a shell function
   3. "source" a file that contains the commands
   4. some combination of 1-3 above
   5. (Bash-specific) compile a new shell builtin command, and load it (via `enable -f cdm.o`, or similar)
   6. modify the source for your shell to add a new shell builtin command

The approach currently taken by the `'cdm'` project is a combination of `(2)`
and `(3)` above. A short `cdm` shell function is defined that has the
user-visible interface:
```bash
    $ cdm SOME/WANTED/DIRECTORY
```

The `cdm()` shell function sources the bulk of its implementation from a
`cdm.bash` file, which allows for full error checking and niceties such as:
```bash
    $ cdm --help
```
without needlessly cluttering up the shell configuration script (such as
`~/.bash_profile` or `~/.bashrc`) with the full implementation.

**FIXME:** flesh-out README docs.


# Build instructions

**FIXME:** build instructions coming soon.


# License

GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl.html>

Unless otherwise stated by a different license notice in a particular file,
all files in the `cdm' project are made available under the GNU GPL version 2,
or (at your option) any later version.

See the [COPYING] file for the full license.

Copyright (C) 2020, 2025 Alan D. Salewski <ads@salewski.email>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.


[COPYING]:  ./COPYING  "file: COPYING"

[BASH_GNU]:  https://www.gnu.org/software/bash/  "GNU Bash: project page at gnu.org"
