FROM rocker/binder:3.5.1 
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

USER root
RUN apt-get update && \
	apt-get install -y libzmq3-dev python-pip curl bzip2 neovim libv8-3.14-dev libjq-dev libsasl2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/
RUN pip3 install --no-cache-dir bs4 notedown neovim jupyterlab matplotlib numpy pandas pytrends

