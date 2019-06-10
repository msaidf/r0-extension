FROM rocker/binder:3.5.3
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

RUN pip3 install --no-cache-dir neovim notedown nbdime bookbook RISE bs4 matplotlib numpy pandas pytrends \
	jupyter_nbextensions_configurator jupyter_contrib_nbextensions
RUN nbdime config-git --enable --global
RUN jupyter contrib nbextension install && \
	jupyter nbextensions_configurator enable


USER root
RUN apt-get update && \
	apt-get install -y python-pip wget curl git bzip2 tmux redis-server libzmq3-dev libv8-3.14-dev libjq-dev libsasl2-dev libsodium-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/

RUN install2.r data.table dtplyr reticulate foreach pbapply doMC doRedis janitor rlist glue jsonlite withr pryr rio rdrop2 googledrive googleway googlesheets
RUN install2.r repr IRdisplay shiny pkgdown blogdown bookdown revealjs xaringan prettydoc learnr flexdashboard shinydashboard tufte formattable 
RUN install2.r moonBook reporttools stargazer texreg huxtable DescTools descr compareGroups plotly qwrap2 desctable tableone expss summarytools sjlabelled sjmisc sjPlot gridExtra ggplotgui listviewer
RUN install2.r margins xts zoo tsbox clubSandwich multiwayvcov lfe wfe estimatr

