ARG ENABLE_ASIO
FROM registry.fedoraproject.org/fedora-minimal:38
RUN dnf5 -y --setopt=tsflags=nodocs install \
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
        osslsigncode \
        p7zip \
        patch \
        pcre-devel \
        perl \
        python3 \
        python3-mako \
        ruby \
        sed \
        unzip \
        wget \
        which \
        xz && \
    dnf5 clean all
RUN if [ -n "$ENABLE_ASIO" ]; then \
        cd /usr/local && \
        wget -O /tmp/asiosdk.zip 'https://www.steinberg.net/asiosdk' && \
        unzip /tmp/asiosdk.zip && \
        rm /tmp/asiosdk.zip && \
        mv asiosdk* asiosdk2 && \
        cd /; \
    fi && \
    git clone https://github.com/mxe/mxe.git && cd /mxe && \
    git checkout b57aabf11c6ade24df97c0fc953092ca80dac799 && \
    if [ -n "$ENABLE_ASIO" ]; then \
        sed -i 's%--with-winapi=.*$%--with-winapi=wmme,directx,wdmks,wasapi,asio \\%' src/portaudio.mk; \
    fi && \
    sed -i 's%gcc%g++%' src/portaudio.mk && \
    make -j$(nproc) MXE_TARGETS=x86_64-w64-mingw32.shared \
        pkgconf \
        libsamplerate \
        ogg \
        vorbis \
        portaudio \
        qt6-qtbase \
        qt6-qtdeclarative \
        qt6-qtsvg \
        qtkeychain-qt6 && \
    make -C /mxe clean-junk && \
    rm -rf /mxe/pkg/* /mxe/.ccache /mxe/.git

# meson uses Python's zipapp module and it hardcodes 744 permissions
RUN chmod 755 /mxe/usr/x86_64-pc-linux-gnu/bin/meson

RUN mkdir /usr/src/wahjam2
COPY docker-entrypoint.sh /
USER 1000:1000
ENTRYPOINT /docker-entrypoint.sh
