#
# Build
#
FROM --platform=$TARGETPLATFORM mysql/mysql-server:8.0.32
ARG TARGETARCH

WORKDIR /a

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Tini
# See https://github.com/krallin/tini for the further details
ENV TINI_VERSION v0.18.0
RUN curl -sLfo /tini "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TARGETARCH}" &&\
    chmod +x /tini
ENTRYPOINT ["/tini", "--"]

RUN microdnf install -y gzip cronie

# Register a cronjob
COPY crontab .
RUN crontab crontab && rm crontab

# Install AWS CLI
RUN microdnf install -y unzip
RUN curl -sLfo awscli.zip "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -p).zip" &&\
    unzip awscli.zip &&\
    ./aws/install &&\
    rm -rf awscli.zip awscli ./aws

RUN microdnf clean all

# Copy scripts
COPY do-backup docker-cmd /usr/local/bin/

# The base image checks a local mysqld, which this container does not run, so
# the check fails whether a backup succeeded or not. Nothing acts on the
# status either: Docker does not restart an unhealthy container outside Swarm.
# Whether a dump of the right size reached S3 is do-backup's own ping to a dead
# man's switch, which is the question worth asking about a job that runs once a
# day.
HEALTHCHECK NONE

CMD ["/usr/local/bin/docker-cmd"]
