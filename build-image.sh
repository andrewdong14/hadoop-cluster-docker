#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t zdong/hadoop:latest .

echo ""
