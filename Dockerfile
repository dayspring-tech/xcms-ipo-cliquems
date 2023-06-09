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

# now continue as usual and install xcms, IPO, and cliqueMS
RUN R -e 'BiocManager::install("xcms", version = "3.12")'
RUN R -e 'BiocManager::install("IPO", version = "3.12")'
RUN R -e 'BiocManager::install("cliqueMS", version = "3.12")'

# ultimately we really just wanted to install optparse, xcms, IPO, cliqueMS, purrr, and pracma
COPY check_packages.R /tmp/check_packages.R
RUN Rscript --no-save /tmp/check_packages.R optparse xcms IPO cliqueMS purrr pracma
