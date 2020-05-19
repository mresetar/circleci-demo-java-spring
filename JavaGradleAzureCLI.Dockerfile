FROM circleci/openjdk:11.0.3-jdk-stretch

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

RUN sudo groupadd docker && sudo usermod -aG docker circleci

ENTRYPOINT ["/bin/bash"]
