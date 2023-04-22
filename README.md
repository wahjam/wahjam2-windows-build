# Windows build container image for Wahjam2

This container image provides a Windows cross-compilation environment for
building [Wahjam2](https://github.com/wahjam/wahjam2). The container image can
be used for local builds or in a continuous integration system.

To cross-compile the Wahjam2 source code from the ~/wahjam2 directory on your
machine:

    $ podman run --rm -it --userns=keep-id \
          -v ~/wahjam2:/usr/src/wahjam2:z \
          wahjam2-windows-build

or:

    $ docker run --rm -it -v ~/wahjam2:/usr/src/wahjam2 wahjam2-windows-build

The following container volumes may be set:
- /usr/src/wahjam2: The Wahjam2 source tree.
- /usr/src/wahjam2/installer/<appname>.spc and
  /usr/src/wahjam2/installer/<appname>.pvk: Code signing certificate and
  private key file. Optional, and if present, both must be provided.

The following optional environment variables may be passed to the image:
- APPNAME: The name of the application (<appname>.exe). Defaults to wahjam2.
- ORGNAME: The name of the organization. Defaults to "Wahjam2 Project".
- ORGDOMAIN: The domain name of the organization. Defaults to wahjam.org.
- PVK\_PASSWORD: The code signing private key file password.

The [mxe](https://mxe.cc/) cross-compilation environment is used. The mxe
version is frozen to a specific git tag to ensure that the exact same package
versions (e.g. Qt) are recompiled when the container image is built. From time
to time the mxe version in the Dockerfile will be updated to bring in new
package versions.

This software is made available under the Apache License 2.0.

This software is maintained by Stefan Hajnoczi <stefanha@jammr.net>.
