FROM zchee/h2o
MAINTAINER zchee <zcheeee@gmail.com>

# Set docker-gen version env
ARG DOCKERGEN_VERSION
ENV DOCKERGEN_VERSION ${DOCKERGEN_VERSION:-0.4.3}

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego && \
	chmod u+x /usr/local/bin/forego

# Install docker-gen
RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKERGEN_VERSION/docker-gen-linux-amd64-$DOCKERGEN_VERSION.tar.gz && \
	tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKERGEN_VERSION.tar.gz && \
	rm /docker-gen-linux-amd64-$DOCKERGEN_VERSION.tar.gz

COPY . /app/
WORKDIR /app/

ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]
