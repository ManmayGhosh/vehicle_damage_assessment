# Vehicle Damage Assessment — notebook environment
FROM python:3.11-slim

# opencv needs these system libs even in "headless" mode
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# CPU-only torch/torchvision — smaller image, and Part B (training scaffold)
# doesn't need a GPU to run the smoke test. If you have an NVIDIA GPU and
# want real training speed, replace this line with the CUDA wheel index for
# your CUDA version (see https://pytorch.org/get-started/locally/) and add
# `deploy.resources.reservations.devices` (GPU) to docker-compose.yml.
RUN pip install --no-cache-dir torch torchvision --index-url https://download.pytorch.org/whl/cpu

COPY notebook/ ./notebook/

EXPOSE 8888

# No token/password for local dev convenience — see README before exposing
# this beyond localhost.
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--NotebookApp.token=", \
     "--NotebookApp.password=", \
     "--notebook-dir=/workspace/notebook"]
