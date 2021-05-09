FROM centos:8@sha256:5528e8b1b1719d34604c87e11dcd1c0a20bedf46e83b5632cdeac91b8c04efc1
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
