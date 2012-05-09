Full source and build scripts used to generate this package can be found at
https://bitbucket.org/venix1/mingw-gdc

For Phobos licensing see phobolicense.txt.
For GDC licensing see gpl.txt.

Installation
Extract contents to TDM MinGW directory.

Includes D1 and D2 compilers.  Defaults to D1, D2 can be used by specifying -v2.
-v2 must be used if GDC is used for linking.

Manual Compiling
 * Requires hg with mq extension
 * Mingw/Msys
   * Ensure /crossdev maps to C:/crossdev in /etc/fstab
 * Additional utlities wget and unzip
 * hg qclone https://bitbucket.org/venix1/mingw-gdc
 * hq qpush -a
 * ./build-gdc-tdm.sh