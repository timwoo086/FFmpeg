#!/bin/bash
set -e

# 安装基础编译工具
apt-get update && apt-get install -y \
    build-essential cmake git pkg-config \
    yasm nasm libx264-dev libx265-dev \
    libvpx-dev libmp3lame-dev libopus-dev \
    libfreetype6-dev libass-dev libvorbis-dev \
    libsdl2-dev libva-dev libvdpau-dev \
    libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev

# 编译安装 libavs2（AVS2 解码支持）
git clone https://github.com/pkuvcl/libavs2.git /tmp/libavs2
cd /tmp/libavs2
mkdir build && cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_SHARED_LIBS=ON
make -j$(nproc) && make install
ldconfig  # 更新动态库缓存

# 验证 libavs2 安装
if ! pkg-config --exists libavs2; then
    echo "Error: libavs2 安装失败！"
    exit 1
fi
