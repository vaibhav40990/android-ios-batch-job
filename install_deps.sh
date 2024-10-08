#!/bin/bash
yum install -y git wget zip unzip openssh-clients
amazon-linux-extras enable php7.2
yum clean metadata
amazon-linux-extras install java-openjdk11
yum install -y java-11-openjdk-devel
yum install -y java-1.8.0-amazon-corretto-devel php php-{pear,curl,devel,gd,mbstring,zip,mysqlnd,mysqli,xml,bcmath,pdo,imagick}
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
ln -s /usr/local/bin/composer /usr/bin/composer
composer self-update --1

#1.5_dependecy

#node
yum -y update 
yum install -y gcc-c++ make
yum -y install wget && yum install -y tar && yum install -y gzip
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
echo ". /root/.nvm/nvm.sh" >> /root/.bashrc
echo ". /root/.nvm/nvm.sh" >> /root/.bash_profile
echo ". /root/.nvm/nvm.sh" >> /root/.profile
. /root/.nvm/nvm.sh && nvm install 16

yum install -y openssl

#python
yum install -y python${PYTHON_VERSION} python3-pip
pip3 install --upgrade pip
pip3 install requests beautifulsoup4 Pillow slack_sdk
pip3 install urllib3==1.26.6
yum clean all

# gradle
wget -c https://services.gradle.org/distributions/gradle-6.8.1-bin.zip
unzip -d /opt/gradle gradle-6.8.1-bin.zip
rm gradle-6.8.1-bin.zip

# android sdk
wget -q https://dl.google.com/android/repository/commandlinetools-linux-${SDK_TOOLS}_latest.zip -O /tmp/tools.zip && \
    mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    unzip -qq /tmp/tools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools/* ${ANDROID_SDK_ROOT}/cmdline-tools/${CMDLINE_VERSION} && \
    rm -v /tmp/tools.zip && \
    mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && \
    yes | sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses && \
    sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --install "platform-tools" "extras;google;instantapps"
sdkmanager --sdk_root="${ANDROID_SDK_ROOT}" --install "build-tools;${BUILD_TOOLS}" "platforms;android-${TARGET_SDK}" "platforms;android-33"