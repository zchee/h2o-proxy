h2o-proxy
===
Automated H2O reverse proxy for Docker containers. An alternative [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy).

h2o-proxy sets up a container running [H2O](https://github.com/h2o/h2o) and [docker-gen](https://github.com/jwilder/docker-gen).  
docker-gen generates reverse proxy configs for H2O and reloads H2O use start_server when containers are started and stopped.  


Based `FROM` image is [zchee/docker-h2o](https://github.com/zchee/docker-h2o).

## Install

Building docker container.  

    $ docker build -t zchee/h2o-proxy .

`h2o-proxy` now support the `docker --build-arg` new feature build flag.  
If you use other versions docker-gen,

    $ docker build -t zchee/h2o-proxy --build-arg DOCKER_GEN_VERSION=*.*.* .

Also, Change `DOCKER_HOST` env,

    $ docker build -t zchee/h2o-proxy --build-arg DOCKER_HOST=/path/to/docker.sock .


If you installed `docker` version is not HEAD, type this command instead of.

    $ docker build -t zchee/h2o-proxy -f Dockerfile.no-buildarg .

## Usage

Edit host os's sysctl.conf.  
e.g. [zchee/docker-h2o/sysctl.conf](https://github.com/zchee/docker-h2o/blob/master/sysctl.conf).

To run it:

    $ docker run -d -p 80:80 --net=host -v /var/run/docker.sock:/tmp/docker.sock:ro zchee/h2o-proxy

Then start any containers you want proxied with an env var `VIRTUAL_HOST=subdomain.youdomain.com`

    $ docker run -e VIRTUAL_HOST=foo.bar.com  ...

Provided your DNS is setup to forward foo.bar.com to the a host running h2o-proxy, the request will be routed to a container with the VIRTUAL_HOST env var set.

If your are using `boot2docker` start `h2o-proxy` with:

    $ $(boot2docker shellinit)
    $ docker run -p 80:80 -e DOCKER_HOST -e DOCKER_CERT_PATH -e DOCKER_TLS_VERIFY -v $DOCKER_CERT_PATH:$DOCKER_CERT_PATH -it zchee/h2o-proxy

## Depend packages
- [zchee/docker-h2o](https://github.com/zchee/docker-h2o) docker image
- [H2O](https://github.com/h2o/h2o): Version 1.5
- [docker-gen](https://github.com/jwilder/docker-gen): Version 0.4.1

## TODO

- [ ] Support HTTP/2 Reverse Proxy ( Wait for the support of H2O )
- [x] Not dependent perl and Server::Starter
  - `start_server` use a included script in the H2O
- `reprioritize-blocking-assets` ooptions 
