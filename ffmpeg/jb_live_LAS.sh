#!/bin/sh
#
#Script to record JB Live shows
#
cd /home/$USER/Videos
ffmpeg -i rtsp://videocdn-us.geocdn.scaleengine.net/jblive-iphone/live/jblive.stream/playlist.m3u8 -b 900k -vcodec copy -r 60 -t 02:30:00 -y LAS_`date +%Y%m%d`.avi
cd /home/$USER

