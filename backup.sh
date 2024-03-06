aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
aws configure set region ${AWS_DEFAULT_REGION}

mongodump --username=${MONGODB_ROOT_USER} \
          --password=${MONGODB_ROOT_PASSWORD} \
          --authenticationDatabase=admin \
          --host=${MONGODB_HOST} \
          --port=${MONGODB_PORT} \
          --oplog \
          --gzip \
          --archive=./backup.gz

aws s3 cp ./backup.gz s3://${S3_ENDPOINT}/${S3_BUCKET_NAME}/$(date +%Y-%m-%d-%H-%M-%S)-backup.gz