FROM jupyterhub/jupyterhub:latest
WORKDIR /python

# Install necessary packages
RUN apt update
RUN apt install -y git
RUN pip install jupyter-server notebook jupyterlab
RUN pip install numpy
RUN pip install pandas
RUN pip install matplotlib
RUN pip install scipy

COPY . /python

