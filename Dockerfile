FROM ubuntu:22.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies, AWS CLI, and R 4.5
RUN apt-get update && apt-get install -y \
    software-properties-common \
    dirmngr \
    wget \
    curl \
    gnupg2 \
    ca-certificates \
    && wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | apt-key add - \
    && add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" \
    && apt-get update && apt-get install -y \
    r-base=4.5* \
    r-base-dev=4.5* \
    tar \
    libnetcdf-dev \
    libxml2-dev \
    libjpeg-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    awscli \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN R -e 'install.packages("optparse", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("BiocManager", repos="https://cloud.r-project.org/")'
RUN R -e 'BiocManager::install(version = "3.21")'
RUN R -e 'install.packages("purrr", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("pracma", repos="https://cloud.r-project.org/")'

# install deps for Hmisc
RUN R -e 'install.packages("latticeExtra", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("Formula", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("ggplot2", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("gtable", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("gridExtra", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("data.table", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("htmlTable", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("viridis", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("htmltools", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("base64enc", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("colorspace", repos="https://cloud.r-project.org/")'

# install older version of Hmisc that's compatible with R ~4.0
# Hmisc is a dependency of CAMERA which is a dependency of IPO
RUN R -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/Hmisc/Hmisc_4.8-0.tar.gz", repos=NULL, type="source")'

# now continue as usual and install xcms, IPO, and cliqueMS with latest Bioconductor
RUN R -e 'BiocManager::install("xcms")'
RUN R -e 'BiocManager::install("IPO")'
RUN R -e 'BiocManager::install("cliqueMS")'

# ultimately we really just wanted to install optparse, xcms, IPO, cliqueMS, purrr, and pracma
COPY check_packages.R /tmp/check_packages.R
RUN Rscript --no-save /tmp/check_packages.R optparse xcms IPO cliqueMS purrr pracma
