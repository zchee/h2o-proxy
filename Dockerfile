FROM zchee/buildpack-deps
MAINTAINER zchee <zcheeee@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
      cmake ninja-build && \
      rm -rf /var/lib/apt/lists/*

ENV MAKEFLAGS -j8

RUN git clone https://github.com/h2o/h2o --recursive && \
      cd h2o && \
      cmake -G 'Ninja' -DWITH_BUNDLED_SSL=off . && \
      ninja && \
      ninja install

COPY sysctl.conf /etc/

WORKDIR /

# Install Forego
RUN wget -P /usr/local/bin https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego \
 && chmod u+x /usr/local/bin/forego

ENV DOCKER_GEN_VERSION 0.4.0

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN apt-get update && apt-get install -y --no-install-recommends \
      perl libperl-dev && \
      rm -rf /var/lib/apt/lists/*
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Server::Starter

COPY . /app/
WORKDIR /app/

ENV DOCKER_HOST unix:///tmp/docker.sock

RUN mkdir -p /etc/h2o
COPY h2o.conf /etc/h2o/

RUN mkdir -p /var/run/h2o/ /var/log/h2o/
RUN touch /var/run/h2o/access-log /var/run/h2o/error-log

CMD ["forego", "start", "-r"]
