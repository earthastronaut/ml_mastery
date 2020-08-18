FROM jupyter/scipy-notebook:latest

# Install gcc required for python dep xgboost
RUN conda install -y libgcc-ng

# Set working directory
WORKDIR /app

# Install additional requirements
COPY setup.py .
COPY README.md .
COPY requirements.txt .
COPY src/ ./src/

# Note: building the -e egg-info required root. I couldn't figure out how to
#   get it to write the egg-info file to another location. 
USER root
RUN ${CONDA_DIR}/bin/pip install -r requirements.txt
USER ${NB_USER}
