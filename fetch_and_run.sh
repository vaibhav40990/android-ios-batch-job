#!/bin/bash

#PATH="/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
#BASENAME="${0##*/}"

php /root/php-script.php server_env=${server_env} automation_server_env=${automation_server_env} api_server_url=${api_server_url} build_request_id=${build_request_id} s3_key=${s3_key} s3_secret=${s3_secret} s3_region=${s3_region} s3_bucket_name=${s3_bucket_name} plobal_db_connection=${plobal_db_connection} plobal_db_host=${plobal_db_host} plobal_db_port=${plobal_db_port} plobal_db_database=${plobal_db_database} plobal_db_user=${plobal_db_user} plobal_db_password=${plobal_db_password} refactor_build_android_ios_dir=/root/refactor-build-android-ios log_file=/data/${build_request_id}logs.log server_infra=${server_infra} check1=check1 >> /data/${build_request_id}logs.log


