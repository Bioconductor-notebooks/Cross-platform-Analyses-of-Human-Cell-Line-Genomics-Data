FROM jupyter/r-notebook:599db13f9123

MAINTAINER Abeer Almutairy <abeer1uw@gmail.com>
LABEL authors="Reem Almugbel, Abeer Almutairy"
USER root

# Customized using Jupyter Notebook R Stack https://github.com/jupyter/docker-stacks/tree/master/r-notebook


# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*
   
USER $NB_USER
#WORKDIR ${HOME}
# R packages

RUN conda config --add channels r
RUN conda config --add channels bioconda
RUN conda install --quiet --yes \
    'r-base=3.3.2' \
    'r-irkernel=0.7*' \
    'r-plyr=1.8*' \
    'r-devtools=1.12*' \
    'r-shiny=0.14*' \
    'r-rmarkdown=1.2*' \
    'r-rsqlite=1.1*' \
    'r-reshape2=1.4*' \
    'r-nycflights13=0.2*' \
    'r-caret=6.0*' \
    'r-rcurl=1.95*' \
    'r-xml=3.98_1.5' \
    'r-crayon=1.3*' && conda clean -tipsy
RUN conda install jupyter_contrib_nbextensions
RUN echo "c.NotebookApp.token = u''" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.iopub_data_rate_limit=1e22" >> $HOME/.jupyter/jupyter_notebook_config.py

RUN pip install --upgrade pip
RUN pip install matplotlib

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('plotly')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('cluster')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('stringr')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('base')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('stats')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('bios2mds')" | R --vanilla

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('build-dep')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('r-cran-rgl')" | R --vanilla

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('rgl')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('ggdendro')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('ggplot2')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('RCurl')" | R --vanilla

RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('mclust')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('corpcor')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('bitops')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('heatmaply')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('sparcl')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('ape')" | R --vanilla
RUN echo "source('http://bioconductor.org/biocLite.R'); biocLite('factoextra')" | R --vanilla


WORKDIR /home/jovyan
ADD . /home/jovyan

