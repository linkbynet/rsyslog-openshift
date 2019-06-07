# Syslog

REPOSITORY DIRECTORY STRUCTURE
-------------------

    rsyslog.conf     Generic configuration file mainly include the conf.d directory.
    conf.d/          Contains r-syslog configuration
    Dockerfile       Docker build instruction container is based on [official/centos](https://hub.docker.com/_/centos/) image + [rsyslog](https://www.rsyslog.com/) yum repository

## Configuration

Rsyslog is listening on port 5514 UDP and TCP facility forward everything to a logstash instance.

The following environment variables are used to define logstash server:
* `LOGSTASH_HOST`: host or ip
* `LOGSTASH_PORT`: port

By default only rsyslog errors are shown on the container stdout, if you wan't to see log sent to Logstash, you should enable the display on stdout for logs.

* **STDOUT_ENABLED**: Set it to `yes` to show logs on container output (default: `no`).

# How to update

Done through ci/cd