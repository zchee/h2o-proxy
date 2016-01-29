FROM zchee/h2o
MAINTAINER zchee <k@zchee.io>

# Set docker-gen version env
ARG DOCKERGEN_VERSION
ENV DOCKERGEN_VERSION ${DOCKERGEN_VERSION:-0.5.0}

# Set $DOCKER_HOST env
ENV DOCKER_HOST unix:///tmp/docker.sock

# Install Forego and docker-gen
RUN set -ex && \
	wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego && \
	chmod u+x /usr/local/bin/forego && \
	\
	wget https://github.com/jwilder/docker-gen/releases/download/$DOCKERGEN_VERSION/docker-gen-linux-amd64-$DOCKERGEN_VERSION.tar.gz && \
	tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKERGEN_VERSION.tar.gz && \
	rm /docker-gen-linux-amd64-$DOCKERGEN_VERSION.tar.gz

COPY . /usr/src/app
WORKDIR /usr/src/app

CMD ["forego", "start", "-r"]
