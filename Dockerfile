FROM amazonlinux:2

RUN amazon-linux-extras enable R4
RUN yum -y install R 

RUN amazon-linux-extras enable epel
RUN yum -y install epel-release

RUN yum -y install tar  \
    netcdf-devel \
    libjpeg-devel \
    zlib1g \
    zlib1g-dev \
    libnetcdf-dev \
    libxml2 \
    libxml2-dev \
    libglpk-dev \
    libxext-dev \
    libxt-dev \
    libxml2-devel

RUN R -e 'install.packages("optparse", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("BiocManager", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("magrittr", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("purrr", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("pracma", repos="https://cloud.r-project.org/")'
RUN R -e 'BiocManager::install("MSnbase", version = "3.12")'
RUN R -e 'BiocManager::install("xcms", version = "3.12")'
RUN R -e 'BiocManager::install("IPO", version = "3.12")'
RUN R -e 'BiocManager::install("cliqueMS", version = "3.12")'
