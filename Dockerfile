FROM ubuntu:18.04
MAINTAINER Peter Hartmann <github@peterh.33mail.com>

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt update
RUN apt --yes build-dep qt5-default
RUN apt --yes install libxcb-xinerama0-dev '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev git python

RUN git clone https://code.qt.io/qt/qt5.git

WORKDIR qt5
RUN git checkout v5.12.3
RUN perl init-repository --module-subset=default,-qtwebengine,-qt3d

RUN mkdir /build
WORKDIR /build
ENV MAKEFLAGS=-j4

# for some reason the xcb plugin and qt3d won't compile, so we are building without them
ENTRYPOINT /qt5/configure -debug -opensource -sanitize address -sanitize undefined -confirm-license -nomake examples -nomake tests -no-xcb-xlib && make && make install && cd / && rm -r /build /qt5
