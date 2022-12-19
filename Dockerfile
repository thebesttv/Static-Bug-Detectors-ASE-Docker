FROM ubuntu:20.04

# set time zone to Los Angeles, taken from
# https://github.com/BugSwarm/bugswarm/blob/master/spawner/Dockerfile
RUN ln -snf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime && \
    echo America/Los_Angeles > /etc/timezone

RUN apt-get update && \
    apt-get -y install \
        apt-transport-https ca-certificates \
        curl unzip gnupg lsb-release \
        vim bash-completion sudo openssh-server \
        python3 python3-pip \
        openjdk-8-jdk maven \
        subversion git \
    && \
    curl -fsSL https://get.docker.com | sh -

COPY init.sh /root/
RUN cd /root && bash init.sh && rm init.sh

# defects4j dependencies
RUN apt-get update && apt-get -y install cpanminus && \
    cd /tmp && git clone https://github.com/rjust/defects4j.git && \
    cd defects4j && cpanm --installdeps . && cd / && rm -rf /tmp/defects4j

# BugSwarm & parsing
RUN pip3 install bugswarm-client beautifulsoup4

RUN sudo su thebesttv -c "cd ~/ && \
    git clone https://github.com/thebesttv/Static-Bug-Detectors-ASE-Artifact.git && \
    cd Static-Bug-Detectors-ASE-Artifact && \
    bash analyzers/init_env.sh |& tee ~/log-init_env"

COPY login.sh /root/
ENTRYPOINT cd /root && bash login.sh && bash
