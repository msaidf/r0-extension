FROM rocker/binder:3.6.0
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

RUN pip3 install --no-cache-dir bs4 notedown neovim jupyterlab matplotlib numpy pandas pytrends \
	jupyter_nbextensions_configurator jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install && \
	jupyter nbextensions_configurator enable

USER root
RUN apt-get update && \
	apt-get install -y libzmq3-dev python-pip curl bzip2 libv8-3.14-dev libjq-dev libsasl2-dev libsodium-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

RUN install2.r data.table dtplyr reticulate rdrop2 JuliaCall googledrive googleway googlesheets 
RUN install2.r shiny pkgdown blogdown bookdown revealjs xaringan prettydoc learnr flexdashboard shinydashboard tufte formattable plumber 
RUN install2.r moonBook reporttools stargazer texreg huxtable DescTools descr compareGroups sjPlot sjlabelled sjmisc qwrap2 desctable tableone expss summarytools
