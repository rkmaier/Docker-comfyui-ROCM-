FROM rocm/pytorch:rocm7.1_ubuntu22.04_py3.10_pytorch_release_2.8.0

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-dev \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# ROCm / PyTorch envs
ENV HSA_OVERRIDE_GFX_VERSION=12.0.1
ENV PYTORCH_ROCM_ARCH=gfx1201
ENV COMFYUI_LISTEN="127.0.0.1"

WORKDIR /app

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

# Install Python dependencies
RUN pip3 install -r requirements.txt --no-cache-dir \
 && pip3 install --force-reinstall numpy scipy \
 && pip3 install --index-url https://rocm.nightlies.amd.com/v2/gfx120X-all/ "rocm[libraries,devel]"


CMD ["python3", "main.py", "--listen", "127.0.0.1", "--port", "8081"]
