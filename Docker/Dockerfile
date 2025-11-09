FROM rocm/pytorch:rocm7.1_ubuntu22.04_py3.10_pytorch_release_2.8.0

RUN apt-get update && apt-get install -y \
    git \
    python3-pip \
    python3-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

ENV HSA_OVERRIDE_GFX_VERSION=12.0.1
ENV PYTORCH_ROCM_ARCH=gfx1201

WORKDIR /app

RUN git clone https://github.com/comfyanonymous/ComfyUI.git .

RUN pip3 install -r requirements.txt --no-cache 
RUN pip3 install numpy scipy --force-reinstall

RUN pip3 install --index-url https://rocm.nightlies.amd.com/v2/gfx120X-all/ "rocm[libraries,devel]"

ENV COMFYUI_LISTEN="127.0.0.1"
EXPOSE 8188

VOLUME /app/models/configs

CMD ["python3", "main.py", "--listen", "127.0.0.1", "--port", "8081"]


