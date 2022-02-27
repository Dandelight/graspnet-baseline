FROM pytorch/pytorch:1.10.0-cuda11.3-cudnn8-devel
# apt换源
RUN sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list &&\
        sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
RUN apt-get update
# pip换源
RUN pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
RUN apt-get install git -y
RUN apt-get install ninja-build
RUN pip install torch tensorboard numpy scipy 'open3d>=0.8' Pillow tqdm
RUN apt-get install libgl1-mesa-glx -y
# COPY 之后的语句都会被重新执行一遍
COPY . /content/graspnet-baseline
WORKDIR /content
RUN cd graspnet-baseline &&\
            cd pointnet2 && TORCH_CUDA_ARCH_LIST="7.5" python setup.py install &&\
            cd ../knn && TORCH_CUDA_ARCH_LIST="7.5" python setup.py install

RUN git clone https://hub.fastgit.xyz/graspnet/graspnetAPI.git &&\
            cd graspnetAPI && pip install .

ENTRYPOINT bash
