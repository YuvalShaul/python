FROM jupyterhub/jupyterhub:latest
WORKDIR /analysis

# Install necessary packages
RUN pip install jupyter-server notebook jupyterlab
RUN pip install numpy
RUN pip install pandas
RUN pip install matplotlib
RUN pip install scipy

COPY . /analysis

