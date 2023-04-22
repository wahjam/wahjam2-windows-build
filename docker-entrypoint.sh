#!/bin/sh
set -e

# Do not export the password in case a subprocess logs or saves its environment
export -n PVK_PASSWORD

export MESON=x86_64-w64-mingw32.shared-meson

# meson <0.63 needs the Qt libexec/ path
export PATH=/mxe/usr/bin:/mxe/usr/x86_64-pc-linux-gnu/qt6/libexec:$PATH

# meson picks up these environment variables
export QMAKE=/mxe/usr/x86_64-w64-mingw32.shared/qt6/bin/qmake
export NINJA=/mxe/usr/x86_64-pc-linux-gnu/bin/ninja

cd /usr/src/wahjam2
meson_opts=(-Dbuildtype=release)
if [ -d build ]; then
    meson_opts+=(--reconfigure)
fi
if [ -n "$APPNAME" ]; then
    meson_opts+=(-Dappname="$APPNAME")
fi
if [ -n "$ORGNAME" ]; then
    meson_opts+=(-Dorgname="$ORGNAME")
fi
if [ -n "$ORGDOMAIN" ]; then
    meson_opts+=(-Dorgdomain="$ORGDOMAIN")
fi

$MESON "${meson_opts[@]}" build

cd build
$NINJA

PVK_PASSWORD="$PVK_PASSWORD" /usr/src/wahjam2/installer/windows/make-installer.sh "$(pwd)"
