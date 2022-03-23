FROM amazonlinux:2

RUN amazon-linux-extras enable epel
RUN yum -y install epel-release

RUN yum -y install R tar netcdf-devel libxml2-devel

RUN R -e 'install.packages("optparse", repos="https://cloud.r-project.org/")'
RUN R -e 'install.packages("BiocManager", repos="https://cloud.r-project.org/")'
RUN R -e 'BiocManager::install("xcms")'
RUN R -e 'BiocManager::install("IPO")'
RUN R -e 'BiocManager::install("cliqueMS", version = "3.10")'
