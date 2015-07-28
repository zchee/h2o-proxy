FROM zchee/h2o
MAINTAINER zchee <zcheeee@gmail.com>

WORKDIR /

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

# Install docker-gen
ENV DOCKER_GEN_VERSION 0.4.0
RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

# Install perl & Server::Starter
RUN apt-get update && apt-get install -y --no-install-recommends \
      perl libperl-dev && \
      rm -rf /var/lib/apt/lists/*
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Server::Starter

COPY . /app/
WORKDIR /app/

ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]
