// symbol.h -- D frontend for GCC.
// Copyright (C) 2011, 2012 Free Software Foundation, Inc.

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

#ifndef DMD_SYMBOL_H
#define DMD_SYMBOL_H

#include "root.h"

#include "d-gcc-tree.h"

#include "mtype.h"

enum TypeType
{
  TYnptr = 0x001,
  TYjfunc = 0x010,
};

enum SymbolStorageClass
{
  SC_INVALID,
  SCextern,
  SCstatic,
  SCauto,
  SCglobal,
  SCstruct,
  SCcomdat
};

typedef enum SymbolStorageClass enum_SC;

enum SymbolFL
{
  FL_INVALID,
  FLextern = 0x01,
  FLdata   = 0x02,
};

enum SymbolFlag
{
  SFLnodebug = 0x01,
  SFLweak    = 0x02
};

enum SymbolSegment
{
  INVALID,
  DATA,
  CDATA,
  UDATA
};

// not sure if this needs to inherit object..
// union tree_node; typedef union tree_node dt_t;
struct dt_t;

enum OutputStage
{
  NotStarted,
  InProgress,
  Finished
};

struct FuncFrameInfo;
typedef ArrayBase<struct Thunk> Thunks;

struct Symbol : Object
{
  Symbol (void);

  const char *Sident;
  const char *prettyIdent;
  SymbolStorageClass Sclass;
  SymbolFL Sfl;
  SymbolSegment Sseg;
  int Sflags;

  dt_t *Sdt;

  // Specific to GNU backend
  tree Stree;
  tree ScontextDecl; // The DECL_CONTEXT to use for child declarations, but see IRState::declContext
  tree SframeField;  // FIELD_DECL in frame struct that this variable is allocated in

  // For FuncDeclarations:
  Thunks thunks;
  FuncDeclarations deferredNestedFuncs;
  OutputStage outputStage;
  FuncFrameInfo *frameInfo;
};

struct Thunk
{
  int offset;
  Symbol *symbol;
  Thunk (void);
};

extern Symbol *symbol_calloc (const char *string);
extern Symbol *symbol_name (const char *id, int sclass, TYPE *t);
extern Symbol *struct_calloc (void);
extern Symbol *symbol_generate (SymbolStorageClass sc, TYPE *type);
extern void symbol_func (Symbol *sym);
extern tree check_static_sym (Symbol *sym);
extern void outdata (Symbol *sym);
inline void obj_export (Symbol *, int) { }
extern void obj_moduleinfo (Symbol *sym);
extern void obj_tlssections (void);

extern Symbol *symbol_tree (tree);
extern Symbol *static_sym (void);

#endif
