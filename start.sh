#!/bin/bash
cd "$(dirname "$0")"

if [ ! -f config.yaml ]; then
  echo "config.yaml 不存在，从模板创建..."
  cp config.example.yaml config.yaml
  echo "请编辑 config.yaml 填入你的 API Key，然后重新运行此脚本"
  exit 1
fi

exec ./cli-proxy-api --config config.yaml
