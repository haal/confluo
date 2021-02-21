FROM ubuntu:latest

MAINTAINER Haris Alesevic

RUN apt-get update -qq && apt-get install -y -qq --no-install-recommends \
       build-essential cmake git libboost-all-dev

RUN mkdir -p /opt/confluo
COPY . /opt/confluo

RUN cd /opt/confluo \
	&& mkdir build \
	&& cd build \
	&& cmake -DBUILD_TESTS=OFF -DWITH_PY_CLIENT=OFF -DWITH_JAVA_CLIENT=OFF .. \
        && make -j8 install

RUN mkdir -p /var/db
EXPOSE 9090

ENTRYPOINT ["confluod"]
CMD ["--address=0.0.0.0 --port=9090 -d /var/db 2>/var/log/confluo.stderr 1>/var/log/confluo.stdout"]
