FROM ubuntu:18.04
MAINTAINER Peter Hartmann <github@peterh.33mail.com>

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt update
RUN apt --yes build-dep qt5-default
RUN apt --yes install libxcb-xinerama0-dev '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev git python

RUN git clone https://code.qt.io/qt/qt5.git

WORKDIR qt5
RUN git checkout 5.12
RUN perl init-repository --module-subset=default,-qtwebengine

RUN ./configure -developer-build -opensource -nomake examples -nomake tests
RUN make -j4
