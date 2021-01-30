FROM centos:7@sha256:0f4ec88e21daf75124b8a9e5ca03c37a5e937e0e108a255d890492430789b60e
ARG USER_ID=2000
# Rsyslog is more up to date on Centos that on Debian.
# In version 8.33.0 we can get som env variable in configuration
# https://www.rsyslog.com/doc/v8-stable/rainerscript/constant_strings.html
EXPOSE 5514/tcp 5514/udp
ADD http://rpms.adiscon.com/v8-stable/rsyslog.repo /etc/yum.repos.d/rsyslog.repo 
# Install utilities
RUN yum update -y && \
    yum install -y rsyslog-gnutls telnet 
RUN rm -f /etc/rsyslog.d/*.conf
COPY rsyslog.conf /etc/
COPY conf.d/ /etc/rsyslog.d/
USER ${USER_ID}
ENTRYPOINT ["rsyslogd", "-n"]
