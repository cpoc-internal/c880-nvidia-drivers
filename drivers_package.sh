#!/bin/bash

echo "Downloading required libraries..."

sudo apt install -y linux-headers-$(uname -r)
sudo apt install -y build-essential
sudo apt update
sudo apt install -y linux-tools-$(uname -r)

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu$(lsb_release -sr | tr -d '.')/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt update && sudo apt install -y ibverbs-utils infiniband-diags
sudo apt install -y linux-headers-$(uname -r) build-essential dkms ibverbs-utils infiniband-diags
sudo dkms autoinstall
sudo depmod -a
sudo dkms status

sudo apt update
sudo apt install -y nvidia-driver-580-server-open nvidia-dkms-580-server-open nvidia-fabricmanager-580 nvlsm
sudo dkms autoinstall
sudo dkms status
nvidia-smi

sudo modprobe ib_umad
echo "ib_umad" | sudo tee /etc/modules-load.d/ib_umad.conf
sudo apt-get update
sudo apt-get install -y rdma-core ibverbs-utils
sudo systemctl enable nvidia-fabricmanager.service
sudo systemctl status nvidia-fabricmanager.service -l --no-pager



# ***************doca-**************


wget https://www.mellanox.com/downloads/DOCA/DOCA_v3.3.0/host/doca-host_3.3.0-088000-26.01-ubuntu2404_amd64.deb
sudo dpkg -i doca-host_3.3.0-088000-26.01-ubuntu2404_amd64.deb
sudo apt-get update
sudo apt-get install -y doca-all
sudo apt-get install -y doca-ofed
dpkg -l | grep doca
sudo systemctl enable rshim
sudo systemctl start rshim

sudo mst start
sudo mst status -v

ibv_devinfo
lsmod | grep ib_peermem
sudo cpupower frequency-set -g performance

ls -l /opt/mellanox/doca/

sudo systemctl status rshim



# *************nccl********


apt update
apt install -y cuda-toolkit

sudo apt install libnccl2=2.28.7-1+cuda13.0 libnccl-dev=2.28.7-1+cuda13.0 -y
sudo apt install build-essential devscripts debhelper fakeroot -y
sudo apt install openmpi-bin openmpi-common libopenmpi-dev -y
sudo apt install mpich -y
sudo modprobe ib_core
sudo modprobe nvidia
sudo modprobe nvidia_uvm
#sudo modprobe nvidia-peermem

export CUDA_HOME=/usr/local/cuda
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
nvcc --version

git clone https://github.com/NVIDIA/nccl-tests.git
cd nccl-tests
make CUDA_HOME=/usr/local/cuda
./build/all_reduce_perf -b 8 -e 10g -f 2 -g 4

echo "done"
