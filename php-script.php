<?php

set_time_limit(0);

$args = [];
if( isset($argc) ) {
   for ($i = 1; $i < $argc; $i++) {
       list($key, $val) = explode('=', $argv[$i]);
       $args[$key] = $val;
   }
}

if( sizeof($_GET) !== 0 ){
    $args = array_merge($args, $_GET);
}

if (!array_key_exists("server_infra",$args) || empty($args["server_infra"])){
   $args["server_infra"] = "AWS_BATCH"; 
}

print_r($args);

exec("cat /etc/issue "." >> ".$args['log_file']);

exec("java -version "." >> ".$args['log_file']);

exec(". /root/.nvm/nvm.sh && node -v "." >> ".$args['log_file']);

exec("python3 -V "." >> ".$args['log_file']);

exec("uname -v "." >> ".$args['log_file']);

exec("uname -o "." >> ".$args['log_file']);

exec("uname -a "." >> ".$args['log_file']);

exec("ls -larth /root/fonts "." >> ".$args['log_file']);

exec("ls -larth /root/localprops "." >> ".$args['log_file']);

exec("pwd "." >> ".$args['log_file']);

exec("ls -larth "." >> ".$args['log_file']);

// Update git package for plobalhybrid.
exec("cd /root/plobalhybrid");

chdir("/root/plobalhybrid");

exec("pwd "." >> ".$args['log_file']);

exec("ls -larth "." >> ".$args['log_file']);

exec("git stash"." >> ".$args['log_file']);

exec("git pull origin platform"." >> ".$args['log_file']);


exec("cd ".$args['refactor_build_android_ios_dir']);

chdir($args['refactor_build_android_ios_dir']);

exec("pwd "." >> ".$args['log_file']);

exec("ls -larth "." >> ".$args['log_file']);

exec("git stash"." >> ".$args['log_file']);

exec("git pull origin master"." >> ".$args['log_file']);

$fh = fopen(".env", 'a');

foreach($args as $k=>$v) {
    fwrite($fh, strtoupper($k)."=".$v.PHP_EOL);
    if($k == "plobal_db_user") {
        $k = "plobal_db_username";
        fwrite($fh, strtoupper($k)."=".$v.PHP_EOL);
    }
}

fclose($fh);

exec("ls -larth "." >> ".$args['log_file']);

exec(". /root/.nvm/nvm.sh && php artisan refactor_and_build:app ".$args['server_env']." ".$args['automation_server_env']." ".$args['api_server_url']." ".$args['build_request_id']." ".$args['s3_key']." ".$args['s3_secret']." ".$args['s3_region']." ".$args['s3_bucket_name']." ".$args['plobal_db_connection']." ".$args['plobal_db_host']." ".$args['plobal_db_port']." ".$args['plobal_db_database']." ".$args['plobal_db_user']." ".$args['plobal_db_password']." " .$args['log_file']." ".$args['server_infra']." >> ".$args['log_file']);