#!/bin/bash
set -e  # 脚本出错立即退出，不继续执行

# 1. 安装依赖（调用同目录的 dependencies.sh）
if [ -f ./build-scripts/dependencies.sh ]; then
  source ./build-scripts/dependencies.sh
else
  echo "错误：找不到 dependencies.sh 文件！"
  exit 1
fi

# 2. 验证 FFmpeg 核心配置文件是否存在
if [ ! -f ./configs/ffmpeg-config.sh ]; then
  echo "错误：找不到 ffmpeg-config.sh 配置文件！"
  exit 1
fi

# 3. 配置 FFmpeg（加载自定义编译选项）
CONFIG=$(source ./configs/ffmpeg-config.sh)
echo "FFmpeg 配置命令：$CONFIG"
./configure $CONFIG || { echo "配置 FFmpeg 失败！"; exit 1; }

# 4. 多线程编译（自动适配 CPU 核心数）
echo "开始编译（使用 $(nproc) 个 CPU 核心）..."
make -j$(nproc) || { echo "编译 FFmpeg 失败！"; exit 1; }

# 5. 创建输出目录（避免权限问题）
mkdir -p /output/usr/local
echo "输出目录：/output/usr/local"

# 6. 安装编译产物到输出目录
make install DESTDIR=/output || { echo "安装 FFmpeg 失败！"; exit 1; }

# 7. 打包产物（方便下载，包含 bin/lib/include 等）
cd /output/usr/local
tar -czf /output/ffmpeg-avs2-10bit-linux-x86_64.tar.gz \
  bin include lib share || { echo "打包产物失败！"; exit 1; }

echo "编译完成！产物已保存到 /output/ffmpeg-avs2-10bit-linux-x86_64.tar.gz"
