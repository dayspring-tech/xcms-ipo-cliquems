FROM amazonlinux:2

RUN amazon-linux-extras enable R4
RUN yum -y install R 

RUN amazon-linux-extras enable epel
RUN yum -y install epel-release

RUN yum -y install tar netcdf-devel libxml2-devel libjpeg-devel

RUN R -e 'install.packages("optparse", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("BiocManager", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("purrr", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("pracma", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("latticeExtra", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("https://cran.r-project.org/src/contrib/Archive/Hmisc/Hmisc_4.8-0.tar.gz", repos=NULL, type="source")'
RUN R -e 'BiocManager::install("xcms", version = "3.12")'
RUN R -e 'BiocManager::install("IPO", version = "3.12")'
RUN R -e 'BiocManager::install("cliqueMS", version = "3.12")'
