FROM registry.fedoraproject.org/fedora-minimal:36
RUN microdnf -y update && \
    microdnf -y --setopt=tsflags=nodocs install \
        autoconf \
        automake \
        bash \
        bison \
        bzip2 \
        flex \
        gcc-c++ \
        gdk-pixbuf2-devel \
        gettext \
        git \
        gperf \
        intltool \
        libtool \
        lzip \
        make \
        mesa-libGL-devel \
        mingw32-nsis \
        openssl \
        openssl-devel \
        p7zip \
        patch \
        perl \
        python3 \
        python3-mako \
        ruby \
        sed \
        unzip \
        wget \
        which \
        xz && \
    microdnf clean all
RUN git clone --depth 1 -b build-2022-04-09 https://github.com/mxe/mxe.git && \
    make -C mxe \
         -j$(nproc) \
         MXE_TARGETS=x86_64-w64-mingw32.shared \
         libsamplerate \
         ogg \
         vorbis \
         portaudio \
         qt6-qtbase \
         qt6-qtdeclarative \
         qt6-qtsvg && \
    make -C mxe clean-junk && \
    rm -rf /mxe/pkg/* /mxe/.ccache

# meson uses Python's zipapp module and it hardcodes 744 permissions
RUN chmod 755 /mxe/usr/x86_64-pc-linux-gnu/bin/meson

RUN mkdir /usr/src/wahjam2
COPY docker-entrypoint.sh /
USER 1000:1000
ENTRYPOINT /docker-entrypoint.sh
