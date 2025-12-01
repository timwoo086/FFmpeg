#!/bin/bash
# FFmpeg 编译配置选项（Linux x86_64）
FFMPEG_CONFIG=(
  --prefix=/usr/local
  --enable-gpl
  --enable-version3
  --enable-nonfree
  --enable-shared
  --disable-static
  --disable-doc
  --disable-debug

  # 10bit 支持
  --enable-gray
  --enable-bitstream-filter=extract_extradata
  --enable-libx264
  --enable-libx265
  --enable-encoder=libx264,libx265
  --enable-decoder=libx264,libx265

  # AVS2 支持
  --enable-libavs2
  --enable-decoder=avs2
  --enable-demuxer=avs2

  # 过滤器支持
  --enable-filters
  --enable-filter=scale,crop,overlay,drawtext,transpose,volume

  # 常用依赖
  --enable-libfreetype
  --enable-libass
  --enable-libmp3lame
  --enable-libopus
  --enable-libvorbis
  --enable-libvpx
  --enable-sdl2
  --enable-vaapi
  --enable-vdpau

  # 路径配置（适配 libavs2 安装）
  --extra-cflags="-I/usr/local/include"
  --extra-ldflags="-L/usr/local/lib"
)

# 输出配置命令（供 build.sh 调用）
echo "${FFMPEG_CONFIG[@]}"
