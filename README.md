## Feature

h2o-proxy sets up a container running [H2O](https://github.com/h2o/h2o) and [docker-gen](https://github.com/jwilder/docker-gen).  
docker-gen generates reverse proxy configs for H2O and reloads H2O use start_server when containers are started and stopped.  
An alternative [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy).

Based `FROM` image is [zchee/docker-h2o](https://github.com/zchee/docker-h2o).

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

## TODO

- [ ] Support HTTP/2 Reverse Proxy ( Wait for the support of H2O )
- [x] Not dependent perl and Server::Starter
  - `start_server` use a included script in the H2O

