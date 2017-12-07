FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y curl sudo wget xvfb git apt-utils
RUN sudo apt-get install -y openjdk-7-jdk maven 
RUN apt-get install -y gettext-base
# Install nodejs to local
RUN apt-get update
RUN sudo apt-get install -y libssl-dev
RUN sudo apt-get install -y build-essential

COPY ./bin/setupgcloud /usr/bin/

# Install NVM for more
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 8.4.0 \
    && node -v && npm -v

# Install GCloud
RUN export CLOUD_SDK_REPO="cloud-sdk-trusty" \
    && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
    && sudo apt-get update \
    && sudo apt-get -y install google-cloud-sdk \
    && sudo apt-get install -y kubectl google-cloud-sdk-app-engine-java


CMD ["/bin/bash"]