FROM rocker/geospatial:3.5.3
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

ENV NB_USER rstudio
ENV NB_UID 1000
ENV VENV_DIR /srv/venv

# Set ENV for all programs...
ENV PATH ${VENV_DIR}/bin:$PATH
# And set ENV for R! It doesn't read from the environment...
RUN echo "PATH=${PATH}" >> /usr/local/lib/R/etc/Renviron

# The `rsession` binary that is called by nbrsessionproxy to start R doesn't seem to start
# without this being explicitly set
ENV LD_LIBRARY_PATH /usr/local/lib/R/lib

ENV HOME /home/${NB_USER}
WORKDIR ${HOME}

RUN apt-get update && \
    apt-get -y install python3-venv python3-dev wget curl git bzip2 tmux redis-server libzmq3-dev libv8-3.14-dev libjq-dev libsasl2-dev libsodium-dev libpoppler-cpp-dev && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a venv dir owned by unprivileged user & set up notebook in it
# This allows non-root to install python libraries if required
RUN mkdir -p ${VENV_DIR} && chown -R ${NB_USER} ${VENV_DIR}

RUN install2.r import data.table dtplyr reticulate drake piggyback foreach pbapply doMC doRedis doParallel janitor rlist glue jsonlite withr pryr rio rdrop2 googledrive googleway googlesheets
RUN install2.r repr IRdisplay nbconvertR shiny pkgdown blogdown bookdown revealjs xaringan prettydoc flexdashboard shinydashboard tufte formattable 
RUN install2.r reporttools stargazer texreg huxtable DescTools descr compareGroups qwrap2 desctable expss summarytools sjlabelled sjmisc sjPlot plotly listviewer gridExtra ggplotgui
RUN install2.r margins xts zoo tsbox clubSandwich multiwayvcov lfe wfe estimatr prophet rdrobust rdlocrand rddensity rdmulti rdpower rdd rddtools

RUN wget https://github.com/neovim/neovim/releases/download/v0.3.7/nvim.appimage
RUN chmod u+x nvim.appimage 
RUN ./nvim.appimage --appimage-extract
RUN chmod -R 766 squashfs-root
RUN mv squashfs-root /opt/ 
RUN cd /usr/bin
RUN ln -s /opt/squashfs-root/usr/bin/nvim

USER ${NB_USER}
RUN python3 -m venv ${VENV_DIR} && \
    # Explicitly install a new enough version of pip
    pip3 install pip && \
    pip3 install --no-cache-dir \
         nbrsessionproxy==0.6.1 && \
    jupyter serverextension enable --sys-prefix --py nbrsessionproxy && \
    jupyter nbextension install    --sys-prefix --py nbrsessionproxy && \
    jupyter nbextension enable     --sys-prefix --py nbrsessionproxy

RUN R --quiet -e "devtools::install_github('IRkernel/IRkernel')" && \
    R --quiet -e "IRkernel::installspec(prefix='${VENV_DIR}')"

RUN pip3 install --no-cache-dir neovim notedown nbdime bookbook RISE bs4 matplotlib numpy pandas pytrends \
	jupyter_nbextensions_configurator jupyter_contrib_nbextensions jupyterlab
RUN nbdime config-git --enable --global
RUN jupyter contrib nbextension install && \
	jupyter nbextensions_configurator enable
RUN mkdir -p ~/.local/share/nvim/site/autoload/plug.vim && \
    cd ~/.local/share/nvim/site/autoload/plug.vim && \
    wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

CMD jupyter lab --ip 0.0.0.0
