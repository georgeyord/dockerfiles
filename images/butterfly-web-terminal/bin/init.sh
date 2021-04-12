#!/bin/sh

# Set password
echo "root:${PASSWORD}" | chpasswd

butterfly.server.py --port=2233 --unsecure --host=0.0.0.0
