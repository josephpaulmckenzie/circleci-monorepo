# /!/bin/bash 

echo -e "go into project folder"
cd $1
npm install
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
export AWS_DEFAULT_REGION=us-east-1
echo -e "sls deploy new commit"
serverless deploy