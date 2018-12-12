FROM rocker/tidyverse:3.5.1 
# INSTALL JUPYTER
RUN apt-get install -y python3-pip libzmq3-dev python-pip curl bzip2 neovim 
RUN pip3 install jupyter matplotlib numpy pandas bs4 jupyterlab notedown pytrends neovim
RUN python2 -m pip install ipykernel
RUN python2 -m ipykernel install


# INSTALL R KERNEL
RUN Rscript -e "install.packages(c('crayon', 'pbdZMQ'))" -e "devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))" -e "IRkernel::installspec(user=FALSE)"

RUN apt-get install -y libudunits2-dev libgdal-dev libgeos-dev libproj-dev libv8-3.14-dev libjq-dev libprotobuf-dev protobuf-compiler
RUN install2.r remotes selectr caTools filehash pbapply doRedis rlist stargazer texreg DescTools descr janitor rio compareGroups sjPlot sjmisc tidyjson qwrap2 desctable tableone rdrobust rdlocrand rddensity rdd rddtools ClubSandwich multiwayvcov lfe survival gganimate ggplotgui hrbrthemes gridExtra ggrepel rbokeh echarts4r dygraphs sparklyr plumber tsbox tidyquant xts zoo bigmemory biganalytics bigalgebra biglm speedglm synchronicity GGally ggthemes moonBook stargazer reporttools tm tidytext twitteR gtrendsR googlesheets udpipe tensorflow shiny bookdown pkgdown blogdown revealjs prettydoc rticles learnr xaringan flexdashboard shinydashboard tufte data.world blscrapeR pollstR countrycode WDI wbstats eurostat OECD pdfetch psData rgdal tmap leaflet tidycensus IMFData LabourMarketAreas mcmc MCMCpack reticulate rdrop2 JuliaCall googledrive wfe rdmulti rdpower Matching MatchIt Amelia ggfortify rCharts timevis wordcloud2 formattable koRpus CausalImpact profvis ggvis highcharter cem plotly pryr glue prophet tensorflow h2o promises googleway
RUN installGithub.r CommerceDataService/eu.us.opendata ropensci/rnoaa mnpopcenter/ipumsr hrecht/censusapi jcizel/FredR mwaldstein/edgarWebR us-bea/bea.R abresler/forbesListR sboysel/fredr ChristopherLucas/MatchingFrontier hrbrmstr/hrbrthemes hrbrmstr/ggalt rstudio/r2d3 kthohr/BMR ropensci/binman ropensci/wdman ropensci/Selenium kosukeimai/fastLink JohnCoene/echarts4r cttobin/ggthemr yihui/printr ropensci/googleLanguageR ropensci/RSelenium ropensci/arkdb ropensci/skimr ropensci/fulltext mkearney/rmd2jupyter


# INSTALL MIKTEX
RUN apt-get install -y gnupg apt-transport-https ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D6BC243565B2087BC3F897C9277A7293F59E4889 && \
    echo "deb http://miktex.org/download/debian stretch universe" | sudo tee /etc/apt/sources.list.d/miktex.list && \
    apt-get update 
RUN apt-get install -y miktex 
RUN miktexsetup --shared=yes finish 
RUN initexmf --admin --set-config-value [MPM]AutoInstall=1

# INSTALL JULIA
ENV JULIA_PATH /usr/local/julia
ENV PATH $JULIA_PATH/bin:$PATH

# https://julialang.org/juliareleases.asc
# Julia (Binary signing key) <buildbot@julialang.org>
ENV JULIA_GPG 3673DF529D9049477F76B37566E3C7DC03D6E495

# https://julialang.org/downloads/
ENV JULIA_VERSION 0.6.4

RUN set -eux; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	if ! command -v gpg > /dev/null; then \
		apt-get update; \
		apt-get install -y --no-install-recommends \
			gnupg \
			dirmngr \
		; \
		rm -rf /var/lib/apt/lists/*; \
	fi; \
	\
# https://julialang.org/downloads/#julia-command-line-version
# https://julialang-s3.julialang.org/bin/checksums/julia-0.7.0.sha256
# this "case" statement is generated via "update.sh"
	dpkgArch="$(dpkg --print-architecture)"; \
	case "${dpkgArch##*-}" in \
# amd64
		amd64) tarArch='x86_64'; dirArch='x64'; sha256='35211bb89b060bfffe81e590b8aeb8103f059815953337453f632db9d96c1bd6' ;; \
# i386
		i386) tarArch='i686'; dirArch='x86'; sha256='36a40cf0c4bd8f82c3c8b270ba34bb83af2d545bfbab135e8e496520304cb160' ;; \
		*) echo >&2 "error: current architecture ($dpkgArch) does not have a corresponding Julia binary release"; exit 1 ;; \
	esac; \
	\
	folder="$(echo "$JULIA_VERSION" | cut -d. -f1-2)"; \
	curl -fL -o julia.tar.gz.asc "https://julialang-s3.julialang.org/bin/linux/${dirArch}/${folder}/julia-${JULIA_VERSION}-linux-${tarArch}.tar.gz.asc"; \
	curl -fL -o julia.tar.gz     "https://julialang-s3.julialang.org/bin/linux/${dirArch}/${folder}/julia-${JULIA_VERSION}-linux-${tarArch}.tar.gz"; 
\

RUN echo "${sha256} *julia.tar.gz" | sha256sum -c -; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$JULIA_GPG"; \
	gpg --batch --verify julia.tar.gz.asc julia.tar.gz; \
	command -v gpgconf > /dev/null && gpgconf --kill all; \
	rm -rf "$GNUPGHOME" julia.tar.gz.asc; \
	\
	mkdir "$JULIA_PATH"; \
	tar -xzf julia.tar.gz -C "$JULIA_PATH" --strip-components 1; \
	rm julia.tar.gz; 
	# apt-mark auto '.*' > /dev/null; \
	# [ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; \
	# apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false;

# INSTALL JULIA KERNEL AND PACKAGES UNDER RSTUDIO USER
RUN julia -e 'ENV["JUPYTER"]="jupyter" ; Pkg.add("IJulia")' 
RUN julia -e 'using IJulia' 

RUN julia -e 'Pkg.add("Stats")'
RUN julia -e 'using Stats' 
RUN julia -e 'Pkg.add("QuantEcon")'
RUN julia -e 'using QuantEcon' 
RUN julia -e 'Pkg.add("DSGE")'
RUN apt-get install -y hdf5-tools ; \ 
    julia -e 'Pkg.build("HDF5")'
RUN julia -e 'using DSGE' 

RUN julia -e 'Pkg.add("Plots")'
RUN julia -e 'using Plots' 
RUN julia -e 'Pkg.add("PyPlot")'
RUN julia -e 'using PyPlot' 
RUN julia -e 'Pkg.add("Gadfly")'
RUN julia -e 'using Gadfly' 

RUN julia -e 'Pkg.add("TextAnalysis")'
RUN julia -e 'using TextAnalysis' 
RUN julia -e 'Pkg.add("Queryverse")'
RUN apt-get install -y gettext  liblzma-dev && python3 -m pip install xlrd
RUN julia -e 'Pkg.build("Cairo"); Pkg.build("Thrift"); Pkg.build("PyCall")'
RUN julia -e 'Pkg.build("ReadStat")'
RUN julia -e 'using Queryverse' 

# RUN julia -e 'Pkg.add.(["JSON", "LazyJSON"])'
# RUN julia -e 'using LazyJSON' 
# RUN julia -e 'using JSON' 
# RUN julia -e 'Pkg.add("Mmap")'
# RUN julia -e 'using Mmap' 
