FROM jupyterhub/jupyterhub:latest
WORKDIR /python

# Install necessary packages
RUN apt-get update
RUN apt install git-all
RUN pip install jupyter-server notebook jupyterlab
RUN pip install numpy
RUN pip install pandas
RUN pip install matplotlib
RUN pip install scipy

COPY . /python

