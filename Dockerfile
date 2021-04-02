#
# Build
#
FROM mysql:8

WORKDIR /a

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Tini
# See https://github.com/krallin/tini for the further details
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Install cron
RUN apt-get update && apt-get -y install cron

# Register a cronjob
COPY crontab .
RUN crontab crontab && rm crontab

# Install php
RUN apt-get update && apt-get install -y php-cli

# Install python
RUN apt-get update && apt-get install -y python3-pip

# Install AWS CLI
RUN python3 -m pip install --upgrade pip &&\
    python3 -m pip install awscli

# Copy scripts
COPY do-backup docker-cmd /usr/local/bin/

CMD ["/usr/local/bin/docker-cmd"]
