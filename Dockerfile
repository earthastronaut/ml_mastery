FROM jupyter/scipy-notebook:latest

ARG conda_env=python38
ARG py_ver=3.8

RUN mkdir /opt/conda/pkgs && chown -R 1000:100 /opt/conda/pkgs

# you can add additional libraries you want conda to install by listing them below the first line and ending with "&& \"
RUN conda create --quiet --yes -p \
        $CONDA_DIR/envs/$conda_env python=$py_ver ipython ipykernel \
    && conda clean --all -f -y

# create Python 3.x environment and link it to jupyter
RUN $CONDA_DIR/envs/${conda_env}/bin/python -m \
        ipykernel install --user --name=${conda_env} \
    && fix-permissions $CONDA_DIR \
    && fix-permissions /home/$NB_USER

# Install additional requirements
RUN conda install -y libgcc-ng
COPY requirements.txt /tmp/
RUN $CONDA_DIR/envs/${conda_env}/bin/pip install -r /tmp/requirements.txt

# prepend conda environment to path
ENV PATH $CONDA_DIR/envs/${conda_env}/bin:$PATH

# if you want this environment to be the default one, uncomment the following line:
ENV CONDA_DEFAULT_ENV ${conda_env}
