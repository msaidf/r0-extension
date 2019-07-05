FROM rocker/geospatial:3.5.3
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

WORKDIR /opt
RUN wget https://github.com/neovim/neovim/releases/download/v0.3.7/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    chmod -R 766 squashfs-root && \
    ln -s /opt/squashfs-root/usr/bin/nvim /usr/bin/

RUN apt-get update && \
    apt-get -y install  curl git bzip2 tmux redis-server libzmq3-dev libv8-3.14-dev libjq-dev libsasl2-dev libsodium-dev libpoppler-cpp-dev  && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN install2.r rio writexl dbplyr DBI odbc pool dbplot MonetDBLite RMariaDB RPostgreSQL RSQLite mongolite redux storr filehash
RUN install2.r promises futures profvis remotes XML xml2 httr rvest plumber rdrop2 googledrive googleway googlesheets gargle RcppArmadillo  withr pryr
RUN install2.r drake piggyback import data.table dtplyr reticulate janitor rlist glue jsonlite 
RUN install2.r foreach pbapply doMC doRedis doParallel synchronicity bigmemory biganalytics bigalgebra biglm bigrquery speedglm 
RUN install2.r repr IRdisplay formattable shiny pkgdown blogdown bookdown revealjs xaringan prettydoc flexdashboard shinydashboard tufte 
RUN install2.r reporttools stargazer texreg huxtable DescTools descr compareGroups qwrap2 desctable expss summarytools 
RUN install2.r gridExtra ggplotgui  prettyB gganimate ggrepel GGally ggthemes ggfortify sjlabelled sjmisc sjPlot DT
RUN install2.r margins xts zoo tsbox lfe wfe prophet clubSandwich multiwayvcov estimatr rdrobust rdlocrand rddensity rdmulti rdpower rdd rddtools
RUN install2.r rbokeh dygraphs rCharts ggvis timevis highcharter wordcloud2 ggmap tmap leaflet plotly listviewer compareDF
RUN install2.r tm tidytext twitteR gtrendsR koRpus udpipe tensorflow h2o sparklyr tabulizerjars tabulizer
RUN install2.r survival Matching MatchIt cem Amelia mcmc MCMCpack tidybayes shinystan CausalImpact DesignLibrary nleqslv FKF KFAS
RUN install2.r data.world tradestatistics blscrapeR rdhs countrycode WDI wbstats eurostat OECD pdfetch psData IMFData LabourMarketAreas bea.R

RUN installGithub.r ChristopherLucas/MatchingFrontier kthohr/BMR kolesarm/RDHonest ropensci/rnoaa CommerceDataService/eu.us.opendata jcizel/FredR mwaldstein/edgarWebR abresler/forbesListR sboysel/fredr 
RUN installGithub.r ropensci/cyphr ropensci/googleLanguageR ropensci/binman ropensci/wdman ropensci/RSelenium ropensci/arkdb
RUN installGithub.r hrbrmstr/hrbrthemes hrbrmstr/ggalt rstudio/r2d3 kosukeimai/fastLink JohnCoene/echarts4r cttobin/ggthemr yihui/printr mkearney/rmd2jupyter r-lib/fs muschellij2/diffr ropensci/crul

RUN wget http://gecon.r-forge.r-project.org/files/gEcon_1.1.0.tar.gz && \
	   R CMD INSTALL gEcon_1.1.0.tar.gz && \
	   wget http://gecon.r-forge.r-project.org/files/gEcon.iosam_0.2.0.tar.gz && \
	   R CMD INSTALL gEcon.iosam_0.2.0.tar.gz && \
	   wget http://gecon.r-forge.r-project.org/files/gEcon.estimation_0.1.0.tar.gz && \
	   R CMD INSTALL gEcon.estimation_0.1.0.tar.gz

