FROM mongo
# Install Python and Cron
RUN apt-get update && apt-get -y install awscli cron

MAINTAINER János Hidvégi <jani.hidvegi@gmail.com>

COPY backup.sh ./backup.sh
COPY restore.sh ./restore.sh

RUN chmod +x ./backup.sh
RUN chmod +x ./restore.sh

ENTRYPOINT ./backup.sh