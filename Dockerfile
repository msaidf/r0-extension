FROM msaidf/rstudio-preview

RUN apt-get update
RUN apt-get install -y python-pip python3-pip
RUN pip install --upgrade pip
RUN pip3 install --upgrade pip

