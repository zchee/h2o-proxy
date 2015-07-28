h2o: start_server --port 0.0.0.0:80 --pid-file=/var/run/h2o/h2o.pid --status-file=/var/run/h2o/h2o_status -- /usr/local/bin/h2o -c /etc/h2o/h2o.conf
dockergen: docker-gen -watch -only-exposed -notify "start_server --restart --port 0.0.0.0:80 --pid-file=/var/run/h2o/h2o.pid --status-file=/var/run/h2o/h2o_status" /app/h2o.tmpl /etc/h2o/h2o.conf
