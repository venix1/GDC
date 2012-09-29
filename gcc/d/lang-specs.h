/* lang-specs.h -- D frontend for GCC.
   Copyright (C) 2011, 2012 Free Software Foundation, Inc.

   GCC is free software; you can redistribute it and/or modify it under
   the terms of the GNU General Public License as published by the Free
   Software Foundation; either version 3, or (at your option) any later
   version.

   GCC is distributed in the hope that it will be useful, but WITHOUT ANY
   WARRANTY; without even the implied warranty of MERCHANTABILITY or
   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
   for more details.

   You should have received a copy of the GNU General Public License
   along with GCC; see the file COPYING3.  If not see
   <http://www.gnu.org/licenses/>.
*/

/* %{!M} probably doesn't make sense because we would need
   to do that -- -MD and -MMD doesn't sound like a plan for D.... */

{".d", "@d", 0, 1, 0 },
{".D", "@d", 0, 1, 0 },
{".dd", "@d", 0, 1, 0 },
{".DD", "@d", 0, 1, 0 },
{".di", "@d", 0, 1, 0 },
{".DI", "@d", 0, 1, 0 },
{"@d",
  "%{!E:cc1d %i %(cc1_options) %(cc1d) %I %{nostdinc*} %{+e*} %{I*} %{J*}\
    %{M} %{MM} %{!fsyntax-only:%(invoke_as)}}", 0, 1, 0 },

