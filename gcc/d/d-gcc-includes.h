// d-gcc-includes.h -- D frontend for GCC.
// Copyright (C) 2011, 2012 Free Software Foundation, Inc.

// Modified by Iain Buclaw, (C) 2010, 2011, 2012

// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

#ifndef GCC_DCMPLR_DC_GCC_INCLUDES_H
#define GCC_DCMPLR_DC_GCC_INCLUDES_H

#ifdef __cplusplus
extern "C" {
#endif
#include "config.h"
#include "system.h"
#include "coretypes.h"
#include "tm.h"
#ifdef __cplusplus
}
#endif

// GMP is C++-aware, so we cannot included it in an extern "C" block.
#include "gmp.h"

#ifdef __cplusplus
extern "C" {
#endif
#include "tree.h"
#include "real.h"
#include "langhooks.h"
#include "langhooks-def.h"
#include "flags.h"
#include "toplev.h"
#include "target.h"
#include "diagnostic.h"
#include "libfuncs.h"
#include "convert.h"
#include "ggc.h"
#include "opts.h"
#include "tm_p.h"

#include "cgraph.h"
#include "tree-iterator.h"
#include "gimple.h"
#include "tree-dump.h"
#include "tree-inline.h"
#include "vec.h"

#include "tree-pretty-print.h"
#include "common/common-target.h"
#ifdef __cplusplus
}
#endif

#ifdef optimize
#undef optimize
#endif

#endif
