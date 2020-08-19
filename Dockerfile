FROM jupyter/scipy-notebook:latest

# Install gcc required for python dep xgboost
RUN conda install -y libgcc-ng

# Set working directory
WORKDIR /app

# Install additional requirements
COPY requirements.txt .
RUN ${CONDA_DIR}/bin/pip install -r requirements.txt

# Add src package
COPY src/ ./src/
ENV PYTHONPATH='/app'

# Copy remaining files
COPY . .
