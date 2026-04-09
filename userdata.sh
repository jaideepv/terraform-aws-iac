#!/bin/bash
yum update -y
yum install -y docker
systemctl start docker
systemctl enable docker
docker --version
