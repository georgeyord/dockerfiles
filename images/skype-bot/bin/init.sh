#!/bin/bash

# Fix crashing on a startup on Ubuntu server
export DISPLAY=:0

SERVICES="xvfb fluxbox skype sevabot" scripts/start-server.sh start && \
scripts/start-vnc.sh start

echo "Log-in Skype UI using VNCviewer and the following password: ${VNC_PASSWORD}"
echo "Example command: vncviewer localhost"

read -p "Hit any key when you have logged-in Skype in VNC session..."

virtualenv venv
. venv/bin/activate
python setup.py develop

# Start Sevabot and make initial connect attempt to Skype
SERVICES=sevabot scripts/start-server.sh start

read -p "Hit any key when you have accepted Skype dialog for Sevabot control in VNC session..."

# Following will restart Sevabot
SERVICES=sevabot scripts/start-server.sh restart

# Following will ensure Xvnx, Fluxbox, Skype and Sevabot are running
scripts/start-server.sh start

echo "Now, you can the HTTP interafe at: http://localhost:5000 using the following password: ${HTTP_PASSWORD}"
sleep 5

tail -f logs/sevabot.log
