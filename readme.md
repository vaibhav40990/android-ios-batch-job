# Steps to build and test new images

### Take latest branch pull on any ec2 server with atleast 16GB of memory

### checkout to staging or master branch based on environment
## Make below file executable using chmod
fetch_and_run.sh, install_deps.sh, php-script.php

chmod +x install_deps.sh fetch_and_run.sh php-script.php

## Navigate to source folder on EC2 and run the below command to build docker image:-

sudo docker build  -t {image_name} . --no-cache

## Run Docker image using below command

sudo docker run -e "plobal_db_port=3306" -e "s3_region=ap-southeast-1" -e "plobal_db_user=user" -e "automation_server_env=live" -e "build_request_id=12312" -e "s3_secret=s3_secret" -e "s3_bucket_name=plobalapps" -e "plobal_db_password=db_pass" -e "plobal_db_database=plobalappsv2" -e "plobal_db_connection=mysql" -e "s3_key=s3_key" -e "server_env=staging" -e "plobal_db_host=db_url" -e "api_server_url=https=//staging.plobuild.com/"  {image_name}

## Run docker without entrypoint to preserve docker from closing when build fails

sudo docker run --rm --entrypoint="" -dit {image_id}  bash

sudo docker container ls

sudo docker exec -it {container_id} /bin/bash

. /root/.nvm/nvm.sh && php /root/php-script.php server_env="staging" automation_server_env="live" api_server_url="https://staging.plobuild.com/" build_request_id="19220" s3_key="test" s3_secret="test" s3_region="ap-southeast-1" s3_bucket_name="plobalapps" plobal_db_connection="mysql" plobal_db_host="db_url" plobal_db_port="3306" plobal_db_database="plobalappsv2" plobal_db_user="user" plobal_db_password="test" refactor_build_android_ios_dir=/root/refactor-build-android-ios log_file=/data/19220logs.log server_infra="" check1=check1 >> /data/19220logs.log

### check logs at /data/19220logs.log or similar for log path provided

Follow the page for ECR deployment and backend config - https://plobalapps.atlassian.net/wiki/spaces/PA/pages/3720314893/AWS+batch+deployments
