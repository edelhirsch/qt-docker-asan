FROM ubuntu:18.04
MAINTAINER Peter Hartmann <github@peterh.33mail.com>

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt update
RUN apt --yes build-dep qt5-default
RUN apt --yes install libxcb-xinerama0-dev '^libxcb.*-dev' libx11-xcb-dev libglu1-mesa-dev libxrender-dev libxi-dev git python

RUN git clone https://code.qt.io/qt/qt5.git

WORKDIR qt5
RUN git checkout v5.12.1
RUN perl init-repository --module-subset=default,-qtwebengine

# unify with line above:
RUN apt --yes install clang

# Using several sanitizers concurrently is not supported with the configure script yet, so do it manually:
RUN sed -i 's/QMAKE_LFLAGS += -ccc-gcc-name g++/QMAKE_LFLAGS += -ccc-gcc-name g++ -fsanitize=address -fsanitize=undefined\nQMAKE_CFLAGS += -fsanitize=address -fsanitize=undefined\nQMAKE_CXXFLAGS += -fsanitize=address -fsanitize=undefined\n/' qtbase/mkspecs/linux-clang/qmake.conf

RUN cat qtbase/mkspecs/linux-clang/qmake.conf

ENV MAKEFLAGS=-j4
RUN ./configure -platform linux-clang -developer-build -opensource -confirm-license -verbose -nomake examples -nomake tests
RUN make
