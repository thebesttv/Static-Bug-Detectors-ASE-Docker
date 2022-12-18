FROM ubuntu:20.04

# Add https support to apt and use TUNA mirror (printf is used to print
# multiple lines).
#   https://unix.stackexchange.com/a/263803
#   https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/
# RUN apt-get update && \
#     apt-get -y install \
#         apt-transport-https ca-certificates \
#     && \
#     printf "%s\n%s\n%s\n%s\n" > /etc/apt/sources.list \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse' \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse' \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-backports main restricted universe multiverse' \
#         'deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse'

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
        docker.io

COPY init.sh /root/
RUN cd /root && bash init.sh && rm init.sh

# defects4j dependencies
RUN apt-get update && apt-get -y install cpanminus && \
    cd /tmp && git clone https://github.com/rjust/defects4j.git && \
    cd defects4j && cpanm --installdeps . && cd / && rm -rf /tmp/defects4j

# BugSwarm
RUN pip3 install bugswarm-client

RUN sudo su thebesttv -c "cd ~/ && \
    git clone https://github.com/ucd-plse/Static-Bug-Detectors-ASE-Artifact.git && \
    cd Static-Bug-Detectors-ASE-Artifact && \
    bash analyzers/init_env.sh |& tee ~/log-init_env"

COPY login.sh /root/
ENTRYPOINT cd /root && bash login.sh && bash
