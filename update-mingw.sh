#!/bin/sh
# -1. Make sure we know where the top-level GCC source directory is
if test -d gcc && test -d gcc/d && test -f gcc/d/setup-gcc.sh; then
    if test $# -gt 0; then
        :
    else
        echo "Usage: $0 [OPTION] PATH"
        exit 1
    fi
else
    echo "This script must be run from the top-level D source directory."
    exit 1
fi

d_gccsrc=
d_setup_gcc=0
top=`pwd`

# Read command line arguments
for arg in "$@"; do
    case "$arg" in
        --setup) d_setup_gcc=1 ;;
        *)
            if test -z "$d_gccsrc" && test -d "$arg" && test -d "$arg/gcc"; then
                d_gccsrc="$arg";
            else
                echo "error: invalid option '$arg'"
                exit 1
            fi ;;
    esac
done

echo $top $d_gccsrc

# 1. Copy sources
mkdir -p "$d_gccsrc/gcc/d"           && \
  mkdir -p "$d_gccsrc/gcc/testsuite" && \
  cd "$d_gccsrc/gcc"                 && \
  rsync -rav "$top/gcc/d" .          && \
  rsync -rav "$top/gcc/testsuite" .  && \
  mkdir -p "$d_gccsrc/libphobos"     && \
  cd "$d_gccsrc/"                    && \
  rsync -rav "$top/libphobos" .      && \
  cd $top


# 2. Maybe run setup-gcc.sh
if test $d_setup_gcc -eq 1; then
    cd $d_gccsrc             && \
        ./gcc/d/setup-gcc.sh && \
        cd $top
fi

echo "GDC update complete."
exit 0
