FROM centos:7@sha256:e4ca2ed0202e76be184e75fb26d14bf974193579039d5573fb2348664deef76e
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
