FROM centos:7@sha256:285bc3161133ec01d8ca8680cd746eecbfdbc1faa6313bd863151c4b26d7e5a5
ARG USER_ID=2000
# Rsyslog is more up to date on Centos that on Debian.
# In version 8.33.0 we can get som env variable in configuration
# https://www.rsyslog.com/doc/v8-stable/rainerscript/constant_strings.html

EXPOSE 5514/tcp 5514/udp

# Install utilities
RUN yum update -y && \
    yum install -y wget && \
    wget -qO /etc/yum.repos.d/rsyslog.repo http://rpms.adiscon.com/v8-stable/rsyslog.repo && \
    yum install -y rsyslog

RUN rm -f /etc/rsyslog.d/*.conf
COPY rsyslog.conf /etc/
COPY conf.d/ /etc/rsyslog.d/
USER ${USER_ID}
ENTRYPOINT ["rsyslogd", "-n"]
