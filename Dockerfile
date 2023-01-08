#
# Build
#
FROM --platform=$TARGETPLATFORM mysql/mysql-server:8.0.31
ARG TARGETPLATFORM

WORKDIR /a

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Tini
# See https://github.com/krallin/tini for the further details
ENV TINI_VERSION v0.18.0
RUN PLATFORM="$(echo $TARGETPLATFORM | cut -d/ -f2)" &&\
    curl -sLfo /tini "https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${PLATFORM}"
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Install cron
RUN microdnf install -y cronie

# Register a cronjob
COPY crontab .
RUN crontab crontab && rm crontab

# Install php
RUN microdnf install -y php-cli

# Install AWS CLI
RUN microdnf install -y unzip
RUN curl -sLfo awscli.zip "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -p).zip" &&\
    unzip awscli.zip &&\
    ./aws/install &&\
    rm -rf awscli.zip awscli ./aws

RUN microdnf clean all

# Copy scripts
COPY do-backup docker-cmd /usr/local/bin/

CMD ["/usr/local/bin/docker-cmd"]
