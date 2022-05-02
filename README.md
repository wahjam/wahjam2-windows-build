# Windows build container image for Wahjam2

This container image provides a Windows cross-compilation environment for
building [Wahjam2](https://github.com/wahjam/wahjam2). The container image can
be used for local builds or in a continuous integration system.

To cross-compile the Wahjam2 source code from the ~/wahjam2 directory on your
machine:

    $ docker run --rm -it -v ~/wahjam2:/usr/src/wahjam2 wahjam2-windows-build

The [mxe](https://mxe.cc/) cross-compilation environment is used. The mxe
version is frozen to a specific git tag to ensure that the exact same package
versions (e.g. Qt) are recompiled when the container image is built. From time
to time the mxe version in the Dockerfile will be updated to bring in new
package versions.

This software is made available under the Apache License 2.0.

This software is maintained by Stefan Hajnoczi <stefanha@jammr.net>.
