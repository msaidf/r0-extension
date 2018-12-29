FROM rocker/binder:3.5.1 
MAINTAINER "Muhamad Said Fathurrohman" muh.said@gmail.com

USER root
RUN apt-get update && \
	apt-get install -y libzmq3-dev python-pip curl bzip2 neovim libv8-3.14-dev libjq-dev libsasl2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/
RUN pip3 install --no-cache-dir bs4 notedown neovim jupyterlab matplotlib numpy pandas pytrends

RUN install2.r data.table dtplyr dbplyr DBI odbc pool tidypredict dbplot bigrquery MonetDBLite RMariaDB RPostgreSQL RSQLite mongolite redux storr remotes selectr caTools filehash foreach pbapply doMC doRedis rlist stargazer texreg DescTools descr janitor rio compareGroups sjPlot sjmisc tidyjson qwrap2 desctable tableone rdrobust rdlocrand rddensity rdd rddtools ClubSandwich multiwayvcov lfe survival gganimate ggplotgui hrbrthemes gridExtra ggrepel rbokeh echarts4r dygraphs sparklyr plumber tsbox tidyquant xts zoo bigmemory biganalytics bigalgebra biglm speedglm synchronicity GGally ggthemes moonBook stargazer reporttools tm tidytext twitteR gtrendsR googlesheets udpipe tensorflow shiny bookdown pkgdown blogdown revealjs prettydoc rticles learnr xaringan flexdashboard shinydashboard tufte data.world blscrapeR pollstR countrycode WDI wbstats eurostat OECD pdfetch psData rgdal tmap leaflet tidycensus IMFData LabourMarketAreas mcmc MCMCpack reticulate rdrop2 JuliaCall googledrive wfe rdmulti rdpower Matching MatchIt Amelia ggfortify rCharts timevis wordcloud2 formattable koRpus CausalImpact profvis ggvis highcharter cem plotly pryr glue prophet tensorflow h2o promises googleway

RUN installGithub.r CommerceDataService/eu.us.opendata mnpopcenter/ipumsr hrecht/censusapi jcizel/FredR mwaldstein/edgarWebR us-bea/bea.R abresler/forbesListR sboysel/fredr ChristopherLucas/MatchingFrontier hrbrmstr/hrbrthemes hrbrmstr/ggalt rstudio/r2d3 kthohr/BMR kosukeimai/fastLink JohnCoene/echarts4r cttobin/ggthemr yihui/printr ropensci/rnoaa ropensci/cyphr ropensci/googleLanguageR ropensci/binman ropensci/wdman ropensci/RSelenium ropensci/arkdb ropensci/skimr ropensci/fulltext mkearney/rmd2jupyter michaelmalick/r-malick rorynolan/strex r-lib/fs kolesarm/RDHonest kolesarm/Robust-Small-Sample-Standard-Errors muschellij2/diffr

USER ${NB_USER}
# RUN python2 -m pip install ipykernel && \
# 	python2 -m ipykernel install
