#!/bin/sh


SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
PLAYER_ROOT=${SHELL_FOLDER}"/../Simulator.app/Contents/MacOS/Simulator"
PRJ_ROOT=${SHELL_FOLDER}"/.."
LOG_PATH="debug.log"
DISBABLE_LOAD_FRAMEWORK="-disable-load-framework"

#竖屏
# RESOLUTION="640x960" # iphone 4/4s
# RESOLUTION="320x480" # iphone 4/4s
# RESOLUTION="300x350" # iphone 4/4s 屏幕模拟iphone尺寸
# RESOLUTION="640x1136" # iphone 5 5s
# RESOLUTION="768x1024" # ipad mini1
# RESOLUTION="1536x2048" # ipad mini2

#横屏
# RESOLUTION="600x400" # iphone 4/4s
# RESOLUTION="350x300" # iphone 4/4s
# RESOLUTION="960x640" # iphone 4/4s
# RESOLUTION="1136x640" # iphone 5 5s
#RESOLUTION="852x480" # 适合分屏
 RESOLUTION="1624x750" # 适合分屏
# RESOLUTION="680x388" # 适合mbp分屏
# RESOLUTION="800x480" # Samsung Nexus S
# RESOLUTION="1280x800" # Samsung Galaxy Note
# RESOLUTION="1024x768" # ipad mini1
# RESOLUTION="2048x1536" # ipad mini2
# RESOLUTION="1100x480" # 自定义
# RESOLUTION="400x480" # 自定义
# RESOLUTION="1236x645" # 自定义

echo $PRJ_ROOT
echo "$PRJ_ROOT"/src/main.lua

"$PLAYER_ROOT" -workdir "$PRJ_ROOT" -resolution "$RESOLUTION" "$DISBABLE_LOAD_FRAMEWORK" -write-debug-log "$LOG_PATH" -entry "$PRJ_ROOT"/src/main.lua
