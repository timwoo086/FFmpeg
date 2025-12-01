#!/bin/bash
set -e

# 1. 安装依赖
source /build-scripts/dependencies.sh

# 2. 进入 FFmpeg 源码目录（GitHub Actions 中默认克隆到 $GITHUB_WORKSPACE）
cd $GITHUB_WORKSPACE

# 3. 配置 FFmpeg
CONFIG=$(source /configs/ffmpeg-config.sh)
./configure $CONFIG

# 4. 编译（使用多线程加速）
make -j$(nproc)

# 5. 安装到输出目录（/output）
make install

# 6. 打包产物（便于下载）
cd /output
tar -czf ffmpeg-avs2-10bit-linux-x86_64.tar.gz *
