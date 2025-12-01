name: FFmpeg Build (AVS2 + 10bit + Filters)

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build-linux:
    runs-on: ubuntu-latest
    steps:
      # 步骤1：克隆仓库（含 FFmpeg 源码和脚本）
      - name: Checkout Source
        uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0

      # 步骤2：给所有脚本添加执行权限（关键！避免 Permission denied）
      - name: Make Scripts Executable
        run: |
          chmod +x ./build-scripts/*.sh
          chmod +x ./configs/*.sh
          chmod +x ./configure  # FFmpeg 自带的配置脚本

      # 步骤3：执行编译脚本（调用 build.sh，Shell 命令都在里面）
      - name: Build FFmpeg
        run: bash ./build-scripts/build.sh

      # 步骤4：上传产物
      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: ffmpeg-avs2-10bit-linux-x86_64
          path: /output/ffmpeg-avs2-10bit-linux-x86_64.tar.gz
          retention-days: 30
          if-no-files-found: error
