FROM edelhirsch/qt-asan-ubsan:v5.12.3

RUN git clone https://github.com/edelhirsch/qt-docker-asan.git
WORKDIR qt-docker-asan/sample-project
RUN /usr/local/Qt-5.12.3/bin/qmake  # use Qt provided with the Docker image
RUN make
RUN ./sample-project
