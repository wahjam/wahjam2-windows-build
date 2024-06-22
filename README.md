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

The following optional environment variables may be passed to the image:
- APPNAME: The name of the application (<appname>.exe). Defaults to wahjam2.
- ORGNAME: The name of the organization. Defaults to "Wahjam2 Project".
- ORGDOMAIN: The domain name of the organization. Defaults to wahjam.org.

If the image was built with `podman build --build-arg=ENABLE_CODE_SIGNING=1`
then the following environment variables may be passed to the image for
SSL.com's CodeSignTool:
- CODE_SIGN_TOOL_USERNAME
- CODE_SIGN_TOOL_PASSWORD
- CODE_SIGN_TOOL_TOTP_SECRET

If the image was built with `podman build --build-arg=ENABLE_ASIO=1` then
Steinberg ASIO support will be available in PortAudio. Note that ASIO has
licensing requirements that you must meet before distributing the software.

The [mxe](https://mxe.cc/) cross-compilation environment is used. The mxe
version is frozen to a specific git tag to ensure that the exact same package
versions (e.g. Qt) are recompiled when the container image is built. From time
to time the mxe version in the Dockerfile will be updated to bring in new
package versions.

This software is made available under the Apache License 2.0.

This software is maintained by Stefan Hajnoczi <stefanha@jammr.net>.
