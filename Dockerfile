FROM jupyter/scipy-notebook:latest

ARG conda_env=python38
ARG py_ver=3.8

RUN mkdir /opt/conda/pkgs && chown -R jovyan /opt/conda/pkgs

# you can add additional libraries you want conda to install by listing them below the first line and ending with "&& \"
RUN conda create --quiet --yes -p \
        $CONDA_DIR/envs/$conda_env python=$py_ver ipython ipykernel \
    && conda clean --all -f -y

# create Python 3.x environment and link it to jupyter
RUN $CONDA_DIR/envs/${conda_env}/bin/python -m \
        ipykernel install --user --name=${conda_env} \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

# Install gcc required for python dep xgboost
RUN conda install -y libgcc-ng

# Set working directory
WORKDIR /app

# Install additional requirements
COPY setup.py README.md requirements.txt ./
COPY src/ ./src/

# Note: building the -e egg-info required root. I couldn't figure out how to
#   get it to write the egg-info file to another location. 
USER root
RUN $CONDA_DIR/envs/${conda_env}/bin/pip install \
    --no-cache-dir \
    -r requirements.txt
USER jovyan

# prepend conda environment to path
ENV PATH $CONDA_DIR/envs/${conda_env}/bin:$PATH

# if you want this environment to be the default one, uncomment the following line:
ENV CONDA_DEFAULT_ENV ${conda_env}
