FROM rocker/binder:3.6.0
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

RUN pip3 install --no-cache-dir neovim notedown nbdime bookbook RISE bs4 matplotlib numpy pandas pytrends \
	jupyter_nbextensions_configurator jupyter_contrib_nbextensions jupyterlab
RUN nbdime config-git --enable --global
RUN jupyter contrib nbextension install && \
	jupyter nbextensions_configurator enable
RUN mkdir -p ~/.local/share/nvim/site/autoload/plug.vim && \
    cd ~/.local/share/nvim/site/autoload/plug.vim && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

USER root
RUN apt-get update && \
    apt-get install -y python-pip wget curl git bzip2 tmux redis-server libzmq3-dev libv8-3.14-dev libjq-dev libsasl2-dev libsodium-dev libpoppler-cpp-dev && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    cd /tmp

RUN install2.r import data.table dtplyr reticulate drake piggyback foreach pbapply doMC doRedis janitor rlist glue jsonlite withr pryr rio rdrop2 googledrive googleway googlesheets
RUN install2.r repr IRdisplay nbconvertR shiny pkgdown blogdown bookdown revealjs xaringan prettydoc flexdashboard shinydashboard tufte formattable 
RUN install2.r reporttools stargazer texreg huxtable DescTools descr compareGroups qwrap2 desctable expss summarytools sjlabelled sjmisc sjPlot plotly listviewer gridExtra ggplotgui
RUN install2.r margins xts zoo tsbox clubSandwich multiwayvcov lfe wfe estimatr prophet rdrobust rdlocrand rddensity rdmulti  rdpower rdd rddtools 

RUN wget https://github.com/neovim/neovim/releases/download/v0.3.7/nvim.appimage
RUN chmod u+x nvim.appimage 
RUN ./nvim.appimage --appimage-extract
RUN chmod -R 766 squashfs-root
RUN mv squashfs-root /opt/ 
RUN cd /usr/bin
RUN ln -s /opt/squashfs-root/usr/bin/nvim 
