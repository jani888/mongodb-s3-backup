aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
aws configure set region ${AWS_DEFAULT_REGION}

# Prompt the user for the backup file to restore
# Make it a list of files in the S3 bucket
aws s3 ls s3://${S3_ENDPOINT}/${S3_BUCKET_NAME}/

# Prompt the user for the file to restore
read -p "Enter the name of the file to restore: " FILE_TO_RESTORE

# Download the file from S3
aws s3 cp s3://${S3_ENDPOINT}/${S3_BUCKET_NAME}/${FILE_TO_RESTORE} /backup/backup.gz

# Ask the user if they want to drop the database before restoring
read -p "Do you want to drop the database before restoring? (y/n): " DROP_DATABASE

# Restore the file to the mongodb database
mongorestore --username=${MONGODB_ROOT_USER} \
             --password=${MONGODB_ROOT_PASSWORD} \
             --authenticationDatabase=admin \
             --host=${MONGODB_SERVICE_NAME} \
             --port=${MONGODB_PORT_NUMBER} \
             --gzip \
             --drop=${DROP_DATABASE} \
             --archive=/backup/backup.gz