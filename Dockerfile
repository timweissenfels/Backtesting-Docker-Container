FROM python:3.8

USER root

RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y install \
        wget \
        curl \
        git \
        make \
        sudo \
	r-base \
        bash-completion && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt-get/lists/*

RUN sudo apt-get -qq -y install screen

# Create user "docker" with sudo powers
RUN useradd -m docker && \
    usermod -aG sudo docker && \
    usermod -G root docker && \
    echo '%sudo ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    cp /root/.bashrc /home/docker/ && \
    mkdir /home/docker/data && \
    chown -R --from=root docker /home/docker

SHELL [ "/bin/bash", "-c" ]

EXPOSE 8888

#INSTALL BT
RUN pip install --upgrade --no-cache-dir pip setuptools wheel && \
    pip install --no-cache-dir numpy jupyter && \
    pip install --no-cache-dir matplotlib==3.2

RUN pip install Cython
RUN pip install pandas
RUN pip install plotly==4.14.3
RUN pip install scipy
RUN git clone https://github.com/pmorissette/bt.git
WORKDIR bt
RUN python setup.py install
RUN pip install backtrader

#INSTALL R Packages
RUN R -e "install.packages('IRkernel',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('quantmod',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('dygraphs',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('PerformanceAnalytics',dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "IRkernel::installspec(user = FALSE)"

# Use C.UTF-8 locale to avoid issues with ASCII encoding
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

#ENV HOME /home/docker
# Have Jupyter notebooks launch without additional command line options
RUN jupyter notebook --generate-config && \
    sed -i -e "/allow_root/ a c.NotebookApp.allow_root = True" ${HOME}/.jupyter/jupyter_notebook_config.py && \
    sed -i -e "/custom_display_url/ a c.NotebookApp.custom_display_url = \'http://localhost:8888\'" ${HOME}/.jupyter/jupyter_notebook_config.py && \
    sed -i -e "/c.NotebookApp.ip/ a c.NotebookApp.ip = '*'" ${HOME}/.jupyter/jupyter_notebook_config.py && \
    sed -i -e "/open_browser/ a c.NotebookApp.open_browser = False" ${HOME}/.jupyter/jupyter_notebook_config.py && \
    sed -i -e "/c.NotebookApp.token/ a c.NotebookApp.token = ''" ${HOME}/.jupyter/jupyter_notebook_config.py

RUN chown -R --from=root docker ${HOME}

#WORKDIR /home/docker/data
#ENV USER docker
#USER docker
#ENV PATH /home/docker/.local/bin:$PATH

RUN pip install backtesting

CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=*", "--allow-root"]
