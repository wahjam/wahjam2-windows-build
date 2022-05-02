#!/bin/sh
set -e

MESON=x86_64-w64-mingw32.shared-meson

# meson <0.63 needs the Qt libexec/ path
export PATH=/mxe/usr/bin:/mxe/usr/x86_64-pc-linux-gnu/qt6/libexec:$PATH

# meson picks up this environment variable
export QMAKE=/mxe/usr/x86_64-w64-mingw32.shared/qt6/bin/qmake
export NINJA=/mxe/usr/x86_64-pc-linux-gnu/bin/ninja

cd /usr/src/wahjam2
if [ -d build ]; then
    $MESON --reconfigure build
else
    $MESON -Dbuildtype=release build
fi

cd build
exec $NINJA
