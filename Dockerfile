FROM amazonlinux:2
RUN mkdir -p /root/.ssh/ && mkdir /data
WORKDIR /data
VOLUME /data

ENV PYTHON_VERSION=37
ENV ANDROID_SDK_ROOT "/opt/sdk"
ENV CMDLINE_VERSION "8.0"
ENV SDK_TOOLS "9123335"
ENV BUILD_TOOLS "31.0.0"
ENV TARGET_SDK "31"
ENV JAVA_HOME "/usr/lib/jvm/jre"
ENV GRADLE_HOME "/opt/gradle/gradle-6.8.1/bin"
ENV ANDROID_HOME ${ANDROID_SDK_ROOT}
ENV PATH $PATH:${ANDROID_SDK_ROOT}/cmdline-tools/${CMDLINE_VERSION}/bin:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/extras/google/instantapps:${ANDROID_SDK_ROOT}/build-tools/${BUILD_TOOLS}:${GRADLE_HOME}

# install required dependencies
COPY install_deps.sh .
RUN chmod +x install_deps.sh
RUN ./install_deps.sh && rm install_deps.sh

# setup refactor-build-android-ios code base
RUN echo "Hi"
ADD repo-key /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa && touch /root/.ssh/known_hosts && ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
RUN git clone --branch=master --depth 1 git@bitbucket.org:plobalapps/refactor-build-android-ios.git /root/refactor-build-android-ios
RUN cd /root/refactor-build-android-ios && composer install --no-dev --no-cache && \
    rm -rf ../.composer

# add other files
ADD apkAutomation.jar /root/apkAutomation.jar
ADD fetch_and_run.sh /root/fetch_and_run.sh
RUN chmod 777 /root/fetch_and_run.sh
ADD fonts /root/fonts
ADD localprops /root/localprops
ADD php-script.php /root/php-script.php

# 1.5 app repo
RUN git clone --branch=platform --depth 1 git@bitbucket.org:plobalapps/plobalhybrid.git /root/plobalhybrid

ENTRYPOINT ["/root/fetch_and_run.sh"]