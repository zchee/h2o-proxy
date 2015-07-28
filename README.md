## Feature

h2o-proxy sets up a container running [H2O](https://github.com/h2o/h2o) and [Server::Starter](https://github.com/kazuho/p5-Server-Starter) and [docker-gen](https://github.com/jwilder/docker-gen).  
docker-gen generates reverse proxy configs for H2O and reloads H2O use Server::Starter when containers are started and stopped.  
An alternative [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy).

## Usage

To run it:

    $ docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro zchee/h2o-proxy

Then start any containers you want proxied with an env var `VIRTUAL_HOST=subdomain.youdomain.com`

    $ docker run -e VIRTUAL_HOST=foo.bar.com  ...

Provided your DNS is setup to forward foo.bar.com to the a host running h2o-proxy, the request will be routed to a container with the VIRTUAL_HOST env var set.

If your are using `boot2docker` start `h2o-proxy` with:

    $ $(boot2docker shellinit)
    $ docker run -p 80:80 -e DOCKER_HOST -e DOCKER_CERT_PATH -e DOCKER_TLS_VERIFY -v $DOCKER_CERT_PATH:$DOCKER_CERT_PATH -it zchee/h2o-proxy

## TODO

- [ ] Support HTTP/2 Reverse Proxy ( Wait for the support of H2O )
- [ ] Not dependent perl and Server::Starter
- [ ] Tuning performance default h2o.conf
- [ ] Tuning performance default sysctl.conf

