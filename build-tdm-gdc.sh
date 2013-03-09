#!/bin/bash

# Default Options
use_hg_revision=1
stage="download"

# Clean stage prior to resuming.  This means patching/configuring should be merge 
# Reorder.  Extract/patching routine.  All files must be extracted then patched.
# Convert to git revision


# kill conftest.exe that's run for more than a minute
# pthreadGC2_64.dll is missing
# Update gccbuilder patch for disabling bootstrap


# PATCH GMP with gmp-4.3.2-w64.patch
# --with-local-prefix is required if not using winsup
# change makefile enable-languages
# libiconv is required

# LPATH to avoid linking errors
# Need built binaries for the dlls in path.

# Allow rebuilding of phobos only.

# Dev mode.  Extract sources apply patches.  Ability to diff and generate new patches

# parse commandline options
# --shell{32,64}. Sets up environment used to compile target
# --{stage} restarts process from stage

usage()
{
cat << EOF
usage: $(basename $0) options

Automates the GDC build process.

OPTIONS:

   -h, --help   Show this message                       
   -s, --shell  Opens a shell with correct GCC environment variables
   -state <state>   Valid States:
                        download
                        verify
                        extract_global
                        patch_global
                        build_global
                        setup_gdc64
                        build_gdc64
                        package_gdc64   
EOF
}

# Handle options parsing
while [ $# -gt 0 ]
do
    case $1 in
        --state)
            echo $2 > state
            shift 2
            #download )
            #verify )
            #extract_global )
            #patch_global )
            #build_global )
            #setup_gdc64 )
            #build_gdc64 )
            #package_gdc64 )
            ;;
    
        --shell)
            echo "--shell: Not implemented"
            exit 1
            ;;
        *|-h|--help)
            usage
            exit 1
    esac
done

if [ $# -eq 0 ]; then
  if [ ! -e state ]; then
    echo download > state
  fi
  echo "No options giving.  Resuming $(cat state)"
fi

              
# Clean stage prior to resuming.  This means patching/configuring should be merged 
# Reorder.  Extract/patching routine.  All files must be extracted then patched.
# Convert to git revision


# kill conftest.exe that's run for more than a minute
# pthreadGC2_64.dll is missing
# Update gccbuilder patch for disabling bootstrap


# PATCH GMP with gmp-4.3.2-w64.patch
# --with-local-prefix is required if not using winsup
# change makefile enable-languages
# libiconv is required

# LPATH to avoid linking errors
# Need built binaries for the dlls in path.

# Allow rebuilding of phobos only.

# Dev mode.  Extract sources apply patches.  Ability to diff and generate new patches

# parse commandline options
# --shell{32,64}. Sets up environment used to compile target
# --{stage} restarts process from stage


# URL of all source prerequisits.
sources=(
    "https://bitbucket.org/venix1/mingw-gdc/downloads/curl-7.26.0-devel-mingw32.zip"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/curl-7.26.0-devel-mingw64.zip"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/sqlite-amalgamation-3071100.zip"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/binutils-2.21.53-1-mingw32-src.tar.lzma"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/gcc-4.6.1-tdmsrc-2.zip"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/gmp-4.3.2.tar.bz2"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/mpfr-2.4.2.tar.bz2"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/binutils-2.21.53-20110731.tar.bz2"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/mpc-0.8.2.tar.gz"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/mingw64-runtime-svn4483-src.zip"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/mingwrt-3.20-mingw32-src.tar.gz"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/w32api-3.17-2-mingw32-src.tar.lzma"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/libiconv-1.13.1.tar.gz"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/cloog-ppl-0.15.11.tar.gz"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/pthreads-w32-cvs20100527-p1.zip"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/expat-2.0.1.tar.gz"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/ppl-0.11.tar.gz"
    "https://bitbucket.org/venix1/mingw-gdc/downloads/gcc-core-4.6.1.tar.bz2"
	"https://bitbucket.org/venix1/mingw-gdc/downloads/gcc-g++-4.6.1.tar.bz2"
)

# URL of compiler pieces.
compilers=(
    "http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%204.6%20series/4.6.1-tdm64-1/gcc-4.6.1-tdm64-1-core.tar.lzma"
    "http://downloads.sourceforge.net/project/tdm-gcc/GNU%20binutils/binutils-2.22.90-tdm64-1.tar.lzma"    
    "http://sourceforge.net/projects/tdm-gcc/files/MinGW-w64%20runtime/GCC%204.6%20series/mingw64-runtime-tdm64-gcc46-svn4483.tar.lzma"
    "http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%204.6%20series/4.6.1-tdm64-1/gcc-4.6.1-tdm64-1-c++.tar.lzma"
    "http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%204.6%20series/4.6.1-tdm-1%20SJLJ/gcc-4.6.1-tdm-1-core.tar.lzma"
    "http://sourceforge.net/projects/tdm-gcc/files/TDM-GCC%204.6%20series/4.6.1-tdm-1%20SJLJ/gcc-4.6.1-tdm-1-c++.tar.lzma"
    
    "http://sourceforge.net/projects/mingw/files/MinGW/Base/binutils/binutils-2.21.53/binutils-2.21.53-1-mingw32-bin.tar.lzma"
    "http://sourceforge.net/projects/mingw/files/MinGW/Base/libiconv/libiconv-1.13.1-1/libiconv-1.13.1-1-mingw32-dll-2.tar.lzma"
    "http://sourceforge.net/projects/mingw/files/MinGW/Base/gettext/gettext-0.17-1/libintl-0.17-1-mingw32-dll-8.tar.lzma"
    "http://sourceforge.net/projects/mingw/files/MinGW/Base/mingw-rt/mingwrt-3.20/mingwrt-3.20-mingw32-dev.tar.gz"
    "http://sourceforge.net/projects/mingw/files/MinGW/Base/mingw-rt/mingwrt-3.20/mingwrt-3.20-mingw32-dll.tar.gz"
    "http://sourceforge.net/projects/mingw/files/MinGW/Base/w32api/w32api-3.17/w32api-3.17-2-mingw32-dev.tar.lzma"
)


# Any other required files.
others=(
)

#Todo? is it possible to make extract and patching information part of arrays?



build_gdc()
{
   path=/crossdev/$1
   build=`dirname $1`
   version=`basename $1`

   pushd $path

   # GCC gengtype has issues with an absolute src path.
   ARGS="GCC_SRC=../gcc-4.6.1 GCC_BUILD=$path/build GCC_STAGE=$path/stage"
   if [ "$build" == "gdc" ]
   then
       echo "Building MinGW"
       PATH=/crossdev/MinGW32/bin:/bin
       /crossdev/gccbuilder/build-tdm-sjlj.sh gcc $ARGS 2>&1 | tee build.log
   else
       echo "Building MinGW64"
       # x86_64-w64-mingw32/bin contains support dlls
       PATH=/crossdev/MinGW64/bin:/crossdev/MinGW64/x86_64-w64-mingw32/bin32:/crossdev/MinGW64/x86_64-w64-mingw32/bin:/bin
       
       # Build sqlite
       pushd sqlite-amalgamation-3071100/
       
       gcc -m32 -o sqlite3_32.o -c sqlite3.c
       gcc -m64 -o sqlite3_64.o -c sqlite3.c
       
       popd
       
       export CC="gcc -m32"
       export CXX="g++ -m32"
       # --debug Disable optimizations.
       #find . -name Makefile -exec sed -i 's/-O2/-O0 -g3/g' {} \; -exec chmod 644 {} \;
       /crossdev/gccbuilder/build-tdm64.sh gcc $ARGS
       
       # Have to compile and install 32 bit libphobos due to multilib issue
       pushd $path/build/x86_64-w64-mingw32/32/libphobos
       make
       make  install prefix=$path/stage
       popd
   fi
   popd
}

# Download a file if it doesn't exist.
check_and_download()
{
    url=$1

    # Extract filename from url.
    file=`basename $url`

    if [ ! -e "src/$file" ]; then
        echo "Downloading $file"
        wget --no-check-certificate $url -P src &> /dev/null 
#    else
#        echo "Not downloading $file, already exists."
    fi
}

# sed -i appears broken on mingw.  Leaving the file read-only.
mingw_sed()
{
    sed -i $1 $2
    # sed -i is broken and will leave the file read-only
    chmod +w $2
}

# Build global support libs.  This is done verbatim using TDM's scripts
build_global_sources()
{
    pushd /crossdev/gccbuilder

    # PATH is set to remove Windows PATH interference and to force the use of
    # the proper compiler.

    # TDM Edition. 
    #PATH=/crossdev/MinGW32/bin:/usr/bin:/bin/
    #./build-tdm-sjlj.sh binutils runtime support-libs prefix

    # TDM64 Edition
    PATH=/crossdev/MinGW64/bin:/bin:/usr/bin
    ./build-tdm64.sh binutils runtime support-libs prefix
    
    popd
}

# Extract all source files into their proper homes.
extract_global_sources()
{
    # This should be done with a loop over compiler/sources array.
    # use file to dtermine file type
    # use file type to grab approriate command

    echo "Extracting gcc-4.6.1-tdmsrc-2.zip"
    unzip -oj src/gcc-4.6.1-tdmsrc-2.zip -d /crossdev/gccbuilder &> /dev/null
    patch -d /crossdev/gccbuilder -p1 < patches/gccbuilder.patch

    # Only build C and D compilers
 
    echo "Extracting gmp-4.3.2.tar.bz2"
    tar xjf src/gmp-4.3.2.tar.bz2 -C /crossdev/src
    patch -d /crossdev/src/gmp-4.3.2 -p1 < /crossdev/gccbuilder/gmp-4.3.2-w64.patch

    tar -xjf src/mpfr-2.4.2.tar.bz2 -C /crossdev/src
    
    tar -xjf src/binutils-2.21.53-20110731.tar.bz2 -C /crossdev/src
    patch -d /crossdev/src/binutils-2.21.53-20110731 -p1 < patches/tls-binutils-2.21.53-20110731.patch

    tar --lzma -xf src/binutils-2.21.53-1-mingw32-src.tar.lzma -C /crossdev/src
    patch -d /crossdev/src/binutils-2.21.53 -p1 < patches/tls-binutils-2.21.53-20110731.patch
    
    tar -xzf src/mpc-0.8.2.tar.gz -C /crossdev/src
    patch -d /crossdev/src/mpc-0.8.2 -p1 < patches/mpc_no_undefined.patch
    
    tar -xzf src/libiconv-1.13.1.tar.gz -C /crossdev/src
    tar -xzf src/cloog-ppl-0.15.11.tar.gz -C /crossdev/src
    tar -xzf src/expat-2.0.1.tar.gz -C /crossdev/src
    tar -xzf src/ppl-0.11.tar.gz -C /crossdev/src
    
    tar -xzf src/mingwrt-3.20-mingw32-src.tar.gz -C /crossdev/src
    patch -d /crossdev/src/mingwrt-3.20-mingw32 -p1 < patches/tls-mingwrt-3.20.patch
    patch -d /crossdev/src/mingwrt-3.20-mingw32 -p1 < patches/tlssup.c.patch
    
    tar --lzma -xf src/w32api-3.17-2-mingw32-src.tar.lzma -C /crossdev/src
    mv /crossdev/src/w32api-3.17-2-mingw32 /crossdev/src/w32api

    unzip -o src/pthreads-w32-cvs20100527-p1.zip -d /crossdev/src &> /dev/null
    # patch is already applied.
    #patch -d /crossdev/src/pthreads-w32-cvs20100527-p1/ -p3 < /crossdev/gccbuilder/w64sup.patch

    unzip -o src/mingw64-runtime-svn4483-src.zip -d /crossdev/src &> /dev/null
    mv /crossdev/src/mingw64-runtime-svn4483-src /crossdev/src/mingw-w64-svn
    patch -d /crossdev/src/mingw-w64-svn/ -p1 < patches/tls-mingw64-runtime.patch

    # Extract TDM compiler
    echo "Extracting TDM GCC"
    tar --lzma -xf src/gcc-4.6.1-tdm-1-core.tar.lzma -C /crossdev/MinGW32
    tar --lzma -xf src/binutils-2.21.53-1-mingw32-bin.tar.lzma -C /crossdev/MinGW32
    tar --lzma -xf src/libiconv-1.13.1-1-mingw32-dll-2.tar.lzma -C /crossdev/MinGW32
    tar --lzma -xf src/libintl-0.17-1-mingw32-dll-8.tar.lzma -C /crossdev/MinGW32
    tar --lzma -xf src/w32api-3.17-2-mingw32-dev.tar.lzma -C /crossdev/MinGW32
    tar --lzma -xf src/gcc-4.6.1-tdm-1-c++.tar.lzma -C /crossdev/MinGW32
    #tar --lzma -xf src/gcc-4.6.1-tdm-1-openmp.tar.lzma -C /crossdev/MinGW32
    tar -xzf src/mingwrt-3.20-mingw32-dev.tar.gz -C /crossdev/MinGW32
    tar -xzf src/mingwrt-3.20-mingw32-dll.tar.gz -C /crossdev/MinGW32

    

    # Extract TDM64 compiler
    echo "Extract TDM64 GCC"
    tar --lzma -xf src/gcc-4.6.1-tdm64-1-core.tar.lzma -C /crossdev/MinGW64
    tar --lzma -xf src/binutils-2.22.90-tdm64-1.tar.lzma -C /crossdev/MinGW64
    tar --lzma -xf src/mingw64-runtime-tdm64-gcc46-svn4483.tar.lzma -C /crossdev/MinGW64
    tar --lzma -xf src/gcc-4.6.1-tdm64-1-c++.tar.lzma -C /crossdev/MinGW64
    #tar --lzma -xf src/gcc-4.6.1-tdm64-1-openmp.tar.lzma -C /crossdev/MinGW64
    
    # Sed makefile to change --enagle-langauges 
}

# Create directory layout required to build
make_directory_layout()
{
    mkdir -p /crossdev/gdc/v1
    mkdir -p /crossdev/gdc/v2
    mkdir -p /crossdev/gdc64/v1
    mkdir -p /crossdev/gdc64/v2
    mkdir -p src
    mkdir -p /crossdev/src
    mkdir -p /crossdev/MinGW32
    mkdir -p /crossdev/MinGW64
}

# Package release
package()
{
    pushd /crossdev/

    if [ "$1" == "gdc" ]
    then
        ARCH=i686-pc-mingw32
        GCC_VER=4.6.1
        D1=$1/v1/stage
        D2=$1/v2/stage

        mkdir -p $1/release/bin
        mkdir -p $1/release/include
        mkdir -p $1/release/lib
        mkdir -p $1/release/lib/gcc/$ARCH/$GCC_VER
        mkdir -p $1/release/libexec/gcc/$ARCH/$GCC_VER
        mkdir -p $1/release/mingw32/bin
        mkdir -p $1/release/mingw32/lib/ldscripts/
        mkdir -p $1/release/share/man/man1/

        # Arch specific files.
        # TDM is mingw32(i386) and GDC is i686-pc-mingw32(i686)
        cp /crossdev/MinGW32/libexec/gcc/mingw32/4.6.1/*.dll $1/release/libexec/gcc/$ARCH/$GCC_VER/
        cp -r $D1/lib/gcc/$ARCH/$GCC_VER/* $1/release/lib/gcc/$ARCH/$GCC_VER/
        cp -r $D1/libexec/gcc/$ARCH/$GCC_VER/* $1/release/libexec/gcc/$ARCH/$GCC_VER/
        rm $1/release/libexec/gcc/$ARCH/$GCC_VER/cc1.exe
        
        # D1 files - Support removed
        cp $D1/lib/libgphobos.a $1/release/lib
        cp $D1/lib/cmain.o $1/release/lib/d1main.o
        cp -rf $D1/include/d $1/release/include
        cp $D1/libexec/gcc/$ARCH/$GCC_VER/cc1d.exe $1/release/libexec/gcc/$ARCH/$GCC_VER/cc1d1.exe
        # separate debug info from exe
        
        # D2 files
        cp $D2/lib/libdruntime.a $1/release/lib
        cp $D2/lib/libgphobos2.a $1/release/lib
        cp $D2/lib/dmain.o $1/release/lib/dmain.o
        cp -rf $D2/include/d2 $1/release/include
        cp $D2/libexec/gcc/$ARCH/$GCC_VER/cc1d.exe $1/release/libexec/gcc/$ARCH/$GCC_VER/cc1d.exe
        # separate debug info from exe


        # Non unique items
        # gdc.exe must come from D2 compilation.  LIBPHOBOS is redefined on the
        # commandline changing LIBPHOBOS to equal gphobos2.
        cp $D2/bin/gdc.exe $1/release/bin
        cp $D2/bin/gdmd    $1/release/bin
        cp $D2/bin/$ARCH-gdc.exe $1/release/bin
        cp $D2/bin/$ARCH-gdmd    $1/release/bin

        cp $D2/share/man/man1/gdc.1 $1/release/share/man/man1/
        cp $D2/share/man/man1/gdmd.1 $1/release/share/man/man1/
        
        # Runtime requirements
        # Contains patched tlssup.c
        cp /crossdev/runtime-stage-tdm32/lib/libmingw32.a $1/release/lib
        
        cp /crossdev/binutils-stage-tdm32/bin/as.exe $1/release/bin
        cp /crossdev/binutils-stage-tdm32/bin/ld.exe $1/release/bin
        cp /crossdev/binutils-stage-tdm32/mingw32/bin/as.exe $1/release/bin
        cp /crossdev/binutils-stage-tdm32/mingw32/bin/ld.exe $1/release/bin
        
        # linker scripts
        cp /crossdev/binutils-stage-tdm32/mingw32/lib/ldscripts/* $1/release/mingw32/lib/ldscripts/
    else
        # Package 64-bit files
        ARCH=x86_64-w64-mingw32
        GCC_VER=4.6.1
        D1=$1/v1/stage
        D2=$1/v2/stage

        mkdir -p $1/release/bin
        mkdir -p $1/release/include
        mkdir -p $1/release/lib32
        mkdir -p $1/release/lib
        mkdir -p $1/release/libexec/gcc/$ARCH/$GCC_VER
        mkdir -p $1/release/share/man/man1/
        mkdir -p $1/release/$ARCH/bin
        mkdir -p $1/release/$ARCH/lib32
        mkdir -p $1/release/$ARCH/lib/
        mkdir -p $1/release/$ARCH/lib/ldscripts
        
        
        # D1 files - Not supported
        #cp $D1/lib32/libgphobos.a $1/release/lib32
        #cp $D1/lib/libgphobos.a $1/release/lib
        #cp $D1/lib32/cmain.o $1/release/lib32/d1main.o
        #cp $D1/lib/cmain.o $1/release/lib/d1main.o
        #cp -rf $D1/include/d $1/release/include
        #cp $D1/libexec/gcc/$ARCH/$GCC_VER/cc1d.exe $1/release/libexec/gcc/$ARCH/$GCC_VER/cc1d1.exe
        

        # D2 files
        # Multilib compiling not working.  Grab from build directory

        cp $D2/lib/libgphobos2.a $1/release/lib
        cp $D2/lib/libgdruntime.a $1/release/lib
        cp $D2/lib/dmain.o $1/release/lib/dmain.o
        
        cp $D2/lib32/libgphobos2.a $1/release/lib32
        cp $D2/lib32/libgdruntime.a $1/release/lib32
        cp $D2/lib32/dmain.o $1/release/lib32/dmain.o      
        
        cp -rf $D2/include/d $1/release/include
        
        cp $D2/libexec/gcc/$ARCH/$GCC_VER/cc1d.exe $1/release/libexec/gcc/$ARCH/$GCC_VER/

        # Non-unique files.
        cp $D2/bin/gdc.exe $1/release/bin
        cp $D2/bin/gdmd    $1/release/bin
        cp $D2/bin/$ARCH-gdc.exe $1/release/bin
        cp $D2/bin/$ARCH-gdmd    $1/release/bin
        
        # Grab necessary binutil and mingwrt files      
        cp /crossdev/runtime-stage-tdm64/$ARCH/lib/libmingw32.a $1/release/$ARCH/lib
        cp /crossdev/runtime-stage-tdm64/$ARCH/lib32/libmingw32.a $1/release/$ARCH/lib32
        # ld.exe
        cp /crossdev/binutils-stage-tdm64/bin/ld.exe $1/release/bin
        cp /crossdev/binutils-stage-tdm64/$ARCH/bin/ld.exe $1/release/$ARCH/bin        
        # as.exe
        cp /crossdev/binutils-stage-tdm64/bin/as.exe $1/release/bin
        cp /crossdev/binutils-stage-tdm64/$ARCH/bin/as.exe $1/release/$ARCH/bin        
        # pe & pep file  
        cp /crossdev/binutils-stage-tdm64/$ARCH/lib/ldscripts/* $1/release/$ARCH/lib/ldscripts        
        
        # Merge sqlite_ARCH into libgphobos.a
        ar q $1/release/lib32/libgphobos2.a $1/v2/sqlite-amalgamation-3071100/sqlite3_32.o
        ar q $1/release/lib/libgphobos2.a   $1/v2/sqlite-amalgamation-3071100/sqlite3_64.o
        
        # Copy libcurl files to release
        cp -rf $1/v2/curl-7.26.0-devel-mingw32/bin/* $1/release/x86_64-w64-mingw32/bin32
        cp -r $1/v2/curl-7.26.0-devel-mingw32/include/* $1/release/x86_64-w64-mingw32/include
        cp -r $1/v2/curl-7.26.0-devel-mingw32/lib/* $1/release/x86_64-w64-mingw32/lib32
        mkdir -p $1/release/libcurl32/
        cp $1/v2/curl-7.26.0-devel-mingw32/* $1/release/libcurl32/

        cp -r $1/v2/curl-7.26.0-devel-mingw64/bin/* $1/release/x86_64-w64-mingw32/bin
        cp -r $1/v2/curl-7.26.0-devel-mingw64/include/* $1/release/x86_64-w64-mingw32/include/
        cp -r $1/v2/curl-7.26.0-devel-mingw64/lib64/* $1/release/x86_64-w64-mingw32/lib/
        mkdir -p $1/release/libcurl64/
        cp $1/v2/curl-7.26.0-devel-mingw64/* $1/release/libcurl64/
    fi
    
    #Compile gdmd for use outside msys.
    #pp gdmd

    #Separate Debugging Info
    # Bug with symbol truncation causes GDB to fail to load.
    #gdc -g foo.d -o foo.exe
    #objcopy --only-keep-debug foo.exe foo.debug
    #strip -g foo.exe
    #objcopy --add-gnu-debuglink=foo.debug foo.exe
    popd
    
    cp gpl.txt              /crossdev/$1/release
    cp phoboslicense.txt    /crossdev/$1/release
    cp README-gdc-mingw.txt /crossdev/$1/release
    
    #gcc-<ver>-<tdm>-gdc-<revision>.zip
    #gcc-<ver>-<tdm>-gdc-<revision>.tar.lzma    
}

# Patch source files.
patch_global_sources()
{
	echo > /dev/null
}

setup_gdc_build()
{
    path=/crossdev/$1
    version=`basename $path`
    
    rm -rf "$path/*"
    
    # Extract GCC
    tar -xjf src/gcc-core-4.6.1.tar.bz2 -C $path
    tar -xjf src/gcc-g++-4.6.1.tar.bz2 -C $path
    
    
    # Extract sqlite, curl libraries
    unzip -o src/sqlite-amalgamation-3071100.zip -d $path &> /dev/null   
    unzip -o src/curl-7.26.0-devel-mingw32.zip -d $path &> /dev/null
    unzip -o src/curl-7.26.0-devel-mingw64.zip -d $path &> /dev/null
   
    # Grab repository information
    if ! command -v hg &> /dev/null; then
        use_hg_revision=0
    fi
    
    #if [ $use_hg_revision ]; then
        #hg_branch=`hg  identify -b`        
        #hg_revision=`hg identify -n | sed -e 's/^\(.*\)+$/\1/'`
        #hg_id=`hg identify -i | sed -e 's/^\(.*\)+$/\1/'`
    #fi    
    
    # Apply third party patches
    patch -d $path/gcc-4.6.1/ -p1 < patches/mingw-tls-gcc-4.6.x.patch
    
    # TDM patches
    #patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/buildsys.patch #ada
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/defstatic.patch #c++
    #patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/dllinline.patch #Fails
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/eh_shmem.patch #??
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/headerpath.patch
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/lfs.patch #C++
    # Required to avoid missing -lgcc_eh errors. 
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/libgcceh.patch
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/libgomp.patch
    patch -f -d $path/gcc-4.6.1/ -p1 -f < /crossdev/gccbuilder/libs64.patch
    #patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/lto-virtbase.patch#Fails
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/make-rel-pref.patch
    patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/relocate.patch
    #patch -f -d $path/gcc-4.6.1/ -p1 < /crossdev/gccbuilder/win64sup.patch # pthreads
    
    
    
    # Setup D
    ./update-mingw.sh $path/gcc-4.6.1 --setup
    pushd $path/gcc-4.6.1
    chmod 0777 gcc/DEV-PHASE # sed has a permission issue
    
    # Since links are difficult on Windows, especially with Vista and 7.  -hg
    # is not used with this build process.
    #if test "$use_hg_revision" = 1; then
        #gdc_ver="hg r$hg_revision:$hg_id($hg_branch)"
        #dmd_ver=`grep 'version = "v' gcc/d/dfrontend/mars.c | sed -e 's/^.*"v\(.*\)".*$/\1/'` || exit 1
        #gdc_ver_msg="gdc $gdc_ver, using dmd $dmd2_ver"
    
        #chmod 0777 gcc/DEV-PHASE # sed has a permission issue
        #sed -i 's/gdc [a-z0-9. :]*, using dmd [0-9. ]*//g' gcc/DEV-PHASE
        #chmod 0777 gcc/DEV-PHASE # sed has a permission issue
        #cur_DEV_PHASE=`cat gcc/DEV-PHASE`
        #if test -z "$cur_DEV_PHASE"; then
            #echo "$gdc_ver_msg" > gcc/DEV-PHASE
        #else
            #echo "$cur_DEV_PHASE $gdc_ver_msg" > gcc/DEV-PHASE
        #fi              
    #fi
    
    popd
}

# Sanity Checks
# require cmd [version]
requires()
{
  bin=$(which $1 2> /dev/null)
  if [ "$bin" == "" ]; then
    echo "Missing binary $1"
    exit 1
  fi
}
# Make sure MSYS is capable and up to date.
function check_system {  
#     /mingw is required to be empty.
#    if [ "$(ls -A /mingw)" ]; then
#        echo "/mingw must be empty.  Make sure it is not defined in /etc/fstab and try again."
#        exit 1
#    fi

    requires wget 
    requires bzip2
    requires patch
    requires unzip
}

check_system
make_directory_layout

while :
do
state=$(cat state)
echo "Executing $state"
case "$state" in
    download )
        # Clean downloads.
        # Acquire TDM source.
        for source in "${sources[@]}"; do
            check_and_download $source
        done

        # Download lastest TDM 32 and 64 compilers.
        for file in "${compilers[@]}"; do
            check_and_download $file
        done

        # Other downloads.  Patches that are not incorporated into GDC yet.
        for file in "${other[@]}"; do
            check_and_download $file
        done
        
        echo verify > state
    ;;

    verify )
        # Verify md5sums, fail.
        success=1
		if [ ! -e mingw.md5sum ]; then
		  echo -e "\033[1;31m""File md5sum does not exist. Need wget"
		  echo -e "\033[0m""mingw-get install msys-wget"
		  echo download > state;
		  exit
		fi
        for file in $(md5sum -c mingw.md5sum | grep FAILED | cut -d: -f1); do
            echo "Checksum failure for $file. Removing $file"
            rm $file; 
            success=0
        done
        
        if [ "$success" == 1 ]; then
            # success move to next stage
            echo extract_global > state
        else
            # Failed, redownload and exit.
            echo "Failed verifying file checksums.  Please try again"
            echo download > state;
            exit 1;
        fi          
    ;;
    
# Begin support libraries
    extract_global )
        extract_global_sources
        echo patch_global > state
    ;;
    
    patch_global )
        patch_global_sources
        echo build_global > state
    ;;
    
    build_global )
        build_global_sources
        echo setup_gdc64 > state
    ;;

    setup_gdc64 )
        setup_gdc_build "gdc64/v2"
        echo build_gdc64 > state
    ;;

    build_gdc64 )
        build_gdc "gdc64/v2"
        echo package_gdc64 > state
    ;;

    #test_compiler("gdc64/d2")

    package_gdc64 )
        package gdc64
        echo finish > state
    ;;
    
    shell64 )
    ;;
    
    * ) exit
esac
done
