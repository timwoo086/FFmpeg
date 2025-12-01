#!/bin/bash
# FFmpeg 配置选项（适配 Linux x86_64，可按需修改平台）
FFMPEG_CONFIG=(
    # 基础配置
    --prefix=/output  # 输出目录
    --enable-gpl      # 启用 GPL 协议（支持 x264/x265）
    --enable-version3
    --enable-nonfree  # 启用非自由组件（如某些编码器）
    --enable-shared   # 编译动态库（.so）
    --disable-static  # 禁用静态库（可选，减小体积）
    --disable-doc     # 禁用文档（减小体积）
    --disable-debug   # 禁用调试信息（减小体积）

    # 10bit 支持
    --enable-gray     # 支持灰度图（10bit 基础）
    --enable-bitstream-filter=extract_extradata  # 提取 10bit 额外数据
    --enable-encoder=libx264 libx265  # 启用 x264/x265 编码器（支持 10bit）
    --enable-decoder=libx264 libx265  # 启用 x264/x265 解码器（支持 10bit）
    --enable-libx264
    --enable-libx265
    --extra-cflags="-I/usr/local/include"
    --extra-ldflags="-L/usr/local/lib"

    # AVS2 支持（依赖 libavs2）
    --enable-libavs2
    --enable-decoder=avs2  # 启用 AVS2 解码器
    --enable-demuxer=avs2  # 启用 AVS2 解复用器

    # 过滤器支持（全量启用，或按需指定）
    --enable-filters  # 启用所有过滤器（默认）
    # 常用过滤器示例（确保未被禁用）：
    --enable-filter=scale,crop,overlay,drawtext,transpose,volume

    # 其他常用功能
    --enable-libfreetype  # 字幕支持
    --enable-libass       # 字幕渲染
    --enable-libmp3lame   # MP3 编码
    --enable-libopus      # Opus 编码
    --enable-libvorbis    # Vorbis 编码
    --enable-libvpx       # VP8/VP9 支持
    --enable-sdl2         # SDL 播放支持
    --enable-vaapi        # 硬件加速（VA-API）
    --enable-vdpau        # 硬件加速（VDPAU）
)

# 输出配置命令
echo "${FFMPEG_CONFIG[@]}"
