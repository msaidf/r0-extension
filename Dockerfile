FROM rocker/geospatial:3.5.3
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

RUN apt-get update && \
    apt-get -y install  curl git bzip2 tmux redis-server libzmq3-dev libv8-3.14-dev libjq-dev libsasl2-dev libsodium-dev libpoppler-cpp-dev  && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN install2.r -s rio writexl dbplyr DBI odbc pool dbplot MonetDBLite RMariaDB RPostgreSQL RSQLite mongolite bigrquery redux storr filehash arkdb
RUN install2.r -s promises futures profvis remotes XML xml2 httr crul rvest plumber rdrop2 googledrive googleway googlesheets gargle RcppArmadillo  withr pryr
RUN install2.r -s drake piggyback import data.table dtplyr reticulate janitor rlist glue jsonlite fs fastLink tsibble tsibbledata
RUN install2.r -s foreach pbapply doMC doRedis doParallel synchronicity bigmemory biganalytics bigalgebra biglm speedglm 
RUN install2.r -s repr IRdisplay formattable shiny pkgdown blogdown bookdown revealjs xaringan prettydoc flexdashboard shinydashboard tufte officer flextable
RUN install2.r -s stargazer texreg huxtable DescTools descr compareGroups qwraps2 desctable expss summarytools 
RUN install2.r -s prettyB gridExtra ggplotgui ggalt hrbrthemes gganimate ggrepel GGally ggthemes ggfortify sjlabelled sjmisc sjPlot DT mschart rvg
RUN install2.r -s margins xts zoo tsbox tidyquant lfe wfe clubSandwich multiwayvcov estimatr rdrobust rdlocrand rddensity rdmulti rdpower rdd rddtools prophet fable feasts RATest
RUN install2.r -s rbokeh dygraphs r2d3 rCharts ggvis timevis highcharter echarts4r wordcloud2 ggmap tmap leaflet plotly listviewer compareDF diffr igraph DiagrammeR
RUN install2.r -s tm tidytext twitteR gtrendsR koRpus udpipe tensorflow h2o sparklyr tabulizerjars tabulizer greta
RUN install2.r -s survival Matching MatchIt cem Amelia mcmc MCMCpack tidybayes rstan shinystan CausalImpact DesignLibrary nleqslv FKF KFAS
RUN install2.r -s data.world tradestatistics rdhs countrycode WDI wbstats eurostat OECD pdfetch psData IMFData rnoaa fredr

RUN installGithub.r -u FALSE ChristopherLucas/MatchingFrontier kthohr/BMR kolesarm/RDHonest CommerceDataService/eu.us.opendata abresler/forbesListR  setzler/eventStudy/eventStudy
RUN installGithub.r -u FALSE ropensci/cyphr ropensci/binman ropensci/wdman ropensci/RSelenium cttobin/ggthemr yihui/printr mkearney/rmd2jupyter

RUN wget http://gecon.r-forge.r-project.org/files/gEcon_1.1.0.tar.gz && \
	   R CMD INSTALL gEcon_1.1.0.tar.gz && \
	   wget http://gecon.r-forge.r-project.org/files/gEcon.iosam_0.2.0.tar.gz && \
	   R CMD INSTALL gEcon.iosam_0.2.0.tar.gz && \
	   wget http://gecon.r-forge.r-project.org/files/gEcon.estimation_0.1.0.tar.gz && \
	   R CMD INSTALL gEcon.estimation_0.1.0.tar.gz

