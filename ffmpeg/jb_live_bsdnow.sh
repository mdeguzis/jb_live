#!/bin/sh
#
#Script to record JB Live shows
#
cd /home/$USER/Videos
ffmpeg -f rtsp -rtsp_transport tcp -i rtsp://videocdn-us.geocdn.scaleengine.net/jblive/live/jblive.stream -strict -2 -vcodec copy -t 02:00:00 -y bsdnow_`date +%Y%m%d`.mp4
cd /home/$USER

