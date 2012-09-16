// d-gcc-real.h -- D frontend for GCC.
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

#ifndef GCC_DCMPLR_D_REAL_H
#define GCC_DCMPLR_D_REAL_H

struct real_value;
struct Type;

struct real_t
{
 public:
  // Including gcc/real.h presents too many problems, so
  // just statically allocate enough space for REAL_VALUE_TYPE.
#define REAL_T_SIZE (16 + sizeof (long))/sizeof (long) + 1

  enum Mode
  {
    Float,
    Double,
    LongDouble,
    NumModes
  };

  struct fake_t
  {
    int c;
    int s;
    int e;
    long m[REAL_T_SIZE];
  };

  static void init (void);
  static real_t parse (const char *str, Mode mode);
  static real_t getnan (Mode mode);
  static real_t getsnan (Mode mode);
  static real_t getinfinity (void);

  // This constructor prevent the use of the real_t in a union
  real_t (void) { }
  real_t (const real_t& r);

  const real_value& rv (void) const;
  real_value& rv (void);
  real_t (const real_value& rv);
  real_t (int v);
  real_t (d_uns64 v);
  real_t (d_int64 v);
  real_t (d_float64 d);
  real_t& operator= (const real_t& r);
  real_t& operator= (int v);
  real_t operator+ (const real_t& r);
  real_t operator- (const real_t& r);
  real_t operator- (void);
  real_t operator* (const real_t& r);
  real_t operator/ (const real_t& r);
  real_t operator% (const real_t& r);
  bool operator< (const real_t& r);
  bool operator> (const real_t& r);
  bool operator<= (const real_t& r);
  bool operator>= (const real_t& r);
  bool operator== (const real_t& r);
  bool operator!= (const real_t& r);
  d_uns64 toInt (void) const;
  d_uns64 toInt (Type *real_type, Type *int_type) const;
  real_t convert (Mode to_mode) const;
  real_t convert (Type *to_type) const;
  bool isZero (void);
  bool isNegative (void);
  bool floatCompare (int op, const real_t& r);
  bool isIdenticalTo (const real_t& r) const;
  int format (char *buf, unsigned buf_size) const;
  int formatHex (char *buf, unsigned buf_size) const;
  // for debugging:
  bool isInf (void);
  bool isNan (void);
  bool isSignallingNan (void);
  bool isConversionExact (Mode to_mode) const;
  void dump (void);

 private:
  // prevent this from being used
  real_t& operator= (d_float32)
  { return *this; }

  real_t& operator= (d_float64)
  { return *this; }

  fake_t frv_;
};

// Long double 80 bit floating point value implementation

typedef real_t longdouble;

template<typename T> longdouble ldouble(T x) { return (longdouble) x; }
inline int ld_sprint(char* str, int fmt, longdouble x)
{
    if(fmt == 'a' || fmt == 'A')
        return x.formatHex(str, 46); // don't know the size here, but 46 is the max
    return x.format(str, 46);
}


struct real_t_Properties
{
  real_t maxval, minval, epsilonval /*, nanval, infval */;
  d_int64 dig, mant_dig;
  d_int64 max_10_exp, min_10_exp;
  d_int64 max_exp, min_exp;
};

extern real_t_Properties real_t_properties[real_t::NumModes];

// Macros used by the D frontend are mapped to real_t property values.

#define FLT_MAX real_t_properties[real_t::Float].maxval;                
#define DBL_MAX real_t_properties[real_t::Double].maxval;               
#define LDBL_MAX real_t_properties[real_t::LongDouble].maxval;
#define FLT_MIN real_t_properties[real_t::Float].minval;
#define DBL_MIN real_t_properties[real_t::Double].minval;
#define LDBL_MIN real_t_properties[real_t::LongDouble].minval;
#define FLT_DIG real_t_properties[real_t::Float].dig;
#define DBL_DIG real_t_properties[real_t::Double].dig;
#define LDBL_DIG real_t_properties[real_t::LongDouble].dig;
#define FLT_MANT_DIG real_t_properties[real_t::Float].mant_dig;
#define DBL_MANT_DIG real_t_properties[real_t::Double].mant_dig;
#define LDBL_MANT_DIG real_t_properties[real_t::LongDouble].mant_dig;
#define FLT_MAX_10_EXP real_t_properties[real_t::Float].max_10_exp;
#define DBL_MAX_10_EXP real_t_properties[real_t::Double].max_10_exp;
#define LDBL_MAX_10_EXP real_t_properties[real_t::LongDouble].max_10_exp;
#define FLT_MIN_10_EXP real_t_properties[real_t::Float].min_10_exp;
#define DBL_MIN_10_EXP real_t_properties[real_t::Double].min_10_exp;
#define LDBL_MIN_10_EXP real_t_properties[real_t::LongDouble].min_10_exp;
#define FLT_MAX_EXP real_t_properties[real_t::Float].max_exp;
#define DBL_MAX_EXP real_t_properties[real_t::Double].max_exp;
#define LDBL_MAX_EXP real_t_properties[real_t::LongDouble].max_exp;
#define FLT_MIN_EXP real_t_properties[real_t::Float].min_exp;
#define DBL_MIN_EXP real_t_properties[real_t::Double].min_exp;
#define LDBL_MIN_EXP real_t_properties[real_t::LongDouble].min_exp;
#define FLT_EPSILON real_t_properties[real_t::Float].epsilonval;
#define DBL_EPSILON real_t_properties[real_t::Double].epsilonval;
#define LDBL_EPSILON real_t_properties[real_t::LongDouble].epsilonval;

#endif
