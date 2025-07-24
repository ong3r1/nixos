#!/usr/bin/env bash

# Feed /dev/video0 (real webcam) into /dev/video1 (virtual camera)
gst-launch-1.0 v4l2src device=/dev/video0 ! \
  video/x-raw,framerate=30/1 ! \
  videoconvert ! \
  v4l2sink device=/dev/video1
