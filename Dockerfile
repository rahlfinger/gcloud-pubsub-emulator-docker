FROM google/cloud-sdk:latest

LABEL maintainer "Robert Ahlfinger <robert.ahlfinger@gmail.com>"

RUN add-apt-repository ppa:openjdk-r/ppa  
RUN apt-get update   
RUN apt-get install openjdk-7-jdk  
RUN gcloud components install --quiet beta pubsub-emulator
RUN mkdir -p /var/pubsub

VOLUME /var/pubsub

EXPOSE 8085

CMD [ "gcloud", "beta", "emulators", "pubsub", "start", "--data-dir=/var/pubsub", "--host-port=0.0.0.0:8085", "--log-http", "--verbosity=debug", "--user-output-enabled" ]
