/* d-lang.h -- D frontend for GCC.
   Copyright (C) 2011, 2012 Free Software Foundation, Inc.
 
   GCC is free software; you can redistribute it and/or modify it under
   the terms of the GNU General Public License as published by the Free
   Software Foundation; either version 3, or (at your option) any later
   version.
 
   GCC is distributed in the hope that it will be useful, but WITHOUT ANY
   WARRANTY; without even the implied warranty of MERCHANTABILITY or
   FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
   for more details.
 
   You should have received a copy of the GNU General Public License
   along with GCC; see the file COPYING3. If not see
   <http://www.gnu.org/licenses/>.
 */


#ifndef GCC_DCMPLR_DC_LANG_H
#define GCC_DCMPLR_DC_LANG_H

#include "d-lang-type.h"

/* Nothing is added to tree_identifier; */
struct GTY(()) lang_identifier
{
  struct tree_identifier common;
};

/* This is required to be defined, but we do not use it. */
struct GTY(()) language_function
{
  int unused;
};

/* The DMD front end types have not been integrated into the GCC garbage
   collection system.  Handle this by using the "skip" attribute. */
struct Declaration;
typedef struct Declaration *DeclarationGTYP;
struct GTY(()) lang_decl
{
  DeclarationGTYP GTY((skip)) d_decl;
};

/* Another required, but unused declaration.  This could be simplified, since
   there is no special lang_identifier */
union GTY((desc ("TREE_CODE (&%h.generic) == IDENTIFIER_NODE"),
	   chain_next ("CODE_CONTAINS_STRUCT (TREE_CODE (&%h.generic), TS_COMMON)"
		       " ? ((union lang_tree_node *) TREE_CHAIN (&%h.generic)) : NULL")))
lang_tree_node
{
  union tree_node GTY((tag ("0"),
		       desc ("tree_node_structure (&%h)"))) generic;
  struct lang_identifier GTY((tag ("1"))) identifier;
};

extern GTY(()) tree d_eh_personality_decl;

/* True if the Tdelegate typed expression is not really a variable,
   but a literal function / method reference */
#define D_IS_METHOD_CALL_EXPR(NODE) (TREE_LANG_FLAG_0 (NODE))

/* True if the type is a reference type and it's decl should be marked
   in the backend as DECL_BY_REFERENCE.  For function types is for NRVO.  */
#define D_TYPE_ADDRESSABLE(NODE) (TYPE_LANG_FLAG_0 (NODE))

/* True if the symbol should be made "link one only".  This is used to
   defer calling make_decl_one_only() before the decl has been prepared. */
#define D_DECL_ONE_ONLY(NODE) (DECL_LANG_FLAG_0 (NODE))

/* True if the symbol is a template member.  Need to distinguish
   between templates and other shared static data so that the latter
   is not affected by -femit-templates. */
#define D_DECL_IS_TEMPLATE(NODE) (DECL_LANG_FLAG_1 (NODE))

/* True if the symbol has been marked "static const".  */
#define D_DECL_READONLY_STATIC(NODE) (DECL_LANG_FLAG_2 (NODE))

/* True if a custom static chain has been set-up for function.  */
#define D_DECL_STATIC_CHAIN(NODE) (DECL_LANG_FLAG_3 (FUNCTION_DECL_CHECK (NODE)))

/* True if the symbol is an in/out contract.  */
#define D_DECL_IS_CONTRACT(NODE) (DECL_LANG_FLAG_4 (FUNCTION_DECL_CHECK (NODE)))

/* The D front-end does not use the 'binding level' system for a symbol table,
   It is only needed to get debugging information for local variables and
   otherwise support the backend. */
struct GTY(()) binding_level
{
  /* A chain of declarations. These are in the reverse of the order supplied. */
  tree names;

  /* A pointer to the end of the names chain. Only needed to facilitate
     a quick test if a decl is in the list by checking if its TREE_CHAIN
     is not NULL or it is names_end (in pushdecl_nocheck()). */
  tree names_end;

  /* For each level (except the global one), a chain of BLOCK nodes for
     all the levels that were entered and exited one level down. */
  tree blocks;

  /* The BLOCK node for this level, if one has been preallocated.
     If NULL_TREE, the BLOCK is allocated (if needed) when the level is popped. */
  tree this_block;

  /* The binding level this one is contained in. */
  struct binding_level *level_chain;
};

extern GTY(()) struct binding_level *current_binding_level;
extern GTY(()) struct binding_level *global_binding_level;

enum d_tree_index
{
  DTI_NULL_PTR,
  DTI_VOID_ZERO,
  DTI_VTBL_PTR_TYPE,

  DTI_BOOL_TYPE,
  DTI_CHAR_TYPE,
  DTI_WCHAR_TYPE,
  DTI_DCHAR_TYPE,

  DTI_IFLOAT_TYPE,
  DTI_IDOUBLE_TYPE,
  DTI_IREAL_TYPE,

  DTI_VA_LIST_TYPE,

  /* unused except for gcc builtins. */
  DTI_INTMAX_TYPE,
  DTI_UINTMAX_TYPE,
  DTI_SIGNED_SIZE_TYPE,
  DTI_STRING_TYPE,
  DTI_CONST_STRING_TYPE,
  DTI_NULL,

  DTI_MAX
};

extern GTY(()) tree d_global_trees[DTI_MAX];

#define d_null_pointer                  d_global_trees[DTI_NULL_PTR]
#define d_void_zero_node                d_global_trees[DTI_VOID_ZERO]
#define d_vtbl_ptr_type_node            d_global_trees[DTI_VTBL_PTR_TYPE]
#define d_boolean_type_node             d_global_trees[DTI_BOOL_TYPE]
#define d_char_type_node                d_global_trees[DTI_CHAR_TYPE]
#define d_dchar_type_node               d_global_trees[DTI_DCHAR_TYPE]
#define d_wchar_type_node               d_global_trees[DTI_WCHAR_TYPE]
#define d_ifloat_type_node              d_global_trees[DTI_IFLOAT_TYPE]
#define d_idouble_type_node             d_global_trees[DTI_IDOUBLE_TYPE]
#define d_ireal_type_node               d_global_trees[DTI_IREAL_TYPE]

#define intmax_type_node                d_global_trees[DTI_INTMAX_TYPE]
#define uintmax_type_node               d_global_trees[DTI_UINTMAX_TYPE]
#define signed_size_type_node           d_global_trees[DTI_SIGNED_SIZE_TYPE]
#define string_type_node                d_global_trees[DTI_STRING_TYPE]
#define const_string_type_node          d_global_trees[DTI_CONST_STRING_TYPE]
#define null_node                       d_global_trees[DTI_NULL]


#ifdef __cplusplus
/* In d-lang.cc.  These are called through function pointers
   and do not need to be "extern C". */
tree d_truthvalue_conversion (tree);
void d_add_global_declaration (tree);
tree d_type_promotes_to (tree);

struct Module;
Module *d_gcc_get_output_module (void);

struct lang_type *build_d_type_lang_specific (Type *t);
struct lang_decl *build_d_decl_lang_specific (Declaration *d);

/* In asmstmt.cc */
tree d_build_asm_stmt (tree insn_tmpl, tree outputs, tree inputs, tree clobbers);

/* In d-incpath.cc */
extern const char *iprefix;
extern const char *multilib_dir;
void add_import_paths (bool stdinc);
void add_phobos_versyms (void);

#endif

#ifdef __cplusplus
extern "C" {
#endif

/* In d-lang.cc */
tree pushdecl (tree);
void pushlevel (int);
tree poplevel (int, int, int);

void init_global_binding_level (void);
void set_decl_binding_chain (tree decl_chain);

tree d_unsigned_type (tree);
tree d_signed_type (tree);
tree d_type_for_size (unsigned bits, int unsignedp);
tree d_type_for_mode (enum machine_mode mode, int unsignedp);

void d_init_exceptions (void);

void d_keep (tree t);
void d_free (tree t);

int global_bindings_p (void);
void insert_block (tree);
void set_block (tree);
tree getdecls (void);

/* In d-builtins.c */
extern const struct attribute_spec d_common_attribute_table[];
extern const struct attribute_spec d_common_format_attribute_table[];
tree d_builtin_function (tree);
void d_init_builtins (void);
void d_register_builtin_type (tree, const char *);
void gcc_d_backend_init (void);
void gcc_d_backend_term (void);

/* In d-builtins2.cc */
void d_bi_init (void);
void d_bi_builtin_func (tree);
void d_bi_builtin_type (tree);

/* In d-convert.cc */
tree d_convert_basic (tree, tree);

#ifdef __cplusplus
}
#endif

/* protect from garbage collection */
extern GTY(()) tree d_keep_list;

#include "d-dmd-gcc.h"

#define d_warning(option, ...) warning (option, __VA_ARGS__)

#define d_built_in_decls(FCODE) built_in_decls[FCODE]

#endif
