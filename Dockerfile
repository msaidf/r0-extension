FROM rocker/geospatial:3.6.0
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

RUN apt-get update && \
    apt-get -y install  curl git bzip2 tmux redis-server libzmq3-dev libv8-3.14-dev libjq-dev libsasl2-dev libsodium-dev libpoppler-cpp-dev  && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN install2.r -s rio writexl dbplyr DBI odbc pool dbplot MonetDBLite RMariaDB RPostgreSQL RSQLite mongolite bigrquery redux storr filehash arkdb
RUN install2.r -s promises futures profvis remotes XML xml2 httr crul rvest plumber googleway googlesheets gargle RcppArmadillo withr pryr
RUN install2.r -s drake piggyback import data.table dtplyr reticulate janitor rlist glue jsonlite fs fastLink
RUN install2.r -s foreach pbapply doMC doRedis doParallel biglm speedglm 
RUN install2.r -s repr IRdisplay formattable shiny pkgdown blogdown bookdown revealjs xaringan flexdashboard shinydashboard tufte officer flextable
RUN install2.r -s xts zoo tsbox tidyquant prophet fable feasts tsibble tsibbledata 
RUN install2.r -s margins lfe wfe clubSandwich multiwayvcov estimatr rdrobust rdlocrand rddensity rdmulti rdpower rdd rddtools RATest EventStudy
RUN install2.r -s tm tidytext twitteR gtrendsR koRpus udpipe tensorflow h2o sparklyr tabulizerjars tabulizer
RUN install2.r -s survival Matching MatchIt cem Amelia mcmc MCMCpack tidybayes rstan shinystan CausalImpact greta DesignLibrary nleqslv FKF KFAS
RUN install2.r -s stargazer texreg huxtable DescTools descr compareGroups qwraps2 desctable expss summarytools sjlabelled sjmisc 
RUN install2.r -s prettyB gridExtra ggplotgui ggalt hrbrthemes gganimate ggrepel GGally ggthemes ggfortify sjPlot DT mschart
RUN install2.r -s dygraphs rCharts ggvis timevis echarts4r wordcloud2 ggmap tmap leaflet plotly listviewer compareDF diffr igraph DiagrammeR
RUN install2.r -s data.world tradestatistics rdhs countrycode WDI wbstats eurostat OECD pdfetch psData IMFData rnoaa fredr

RUN installGithub.r -u FALSE ChristopherLucas/MatchingFrontier kthohr/BMR kolesarm/RDHonest CommerceDataService/eu.us.opendata abresler/forbesListR
RUN installGithub.r -u FALSE ropensci/cyphr ropensci/binman ropensci/wdman ropensci/RSelenium cttobin/ggthemr yihui/printr mkearney/rmd2jupyter

WORKDIR /tmp
RUN wget http://gecon.r-forge.r-project.org/files/gEcon_1.1.0.tar.gz && \
    R CMD INSTALL gEcon_1.1.0.tar.gz && \
    wget http://gecon.r-forge.r-project.org/files/gEcon.iosam_0.2.0.tar.gz && \
    R CMD INSTALL gEcon.iosam_0.2.0.tar.gz && \
    wget http://gecon.r-forge.r-project.org/files/gEcon.estimation_0.1.0.tar.gz && \
    R CMD INSTALL gEcon.estimation_0.1.0.tar.gz
