#!/bin/bash

# Firecrawl Zeabur 配置验证脚本

set -e

echo "🔍 开始验证 Firecrawl Zeabur 配置..."
echo ""

# 检查必需文件
echo "📁 检查必需文件..."
required_files=(
    "template.yaml"
    "zeabur.json"
    ".env.zeabur"
    "apps/api/Dockerfile"
    "apps/api/package.json"
    "apps/api/tsconfig.json"
    "apps/playwright-service-ts/Dockerfile"
    "README-ZEABUR.md"
    "DEPLOY.md"
    "test-deployment.sh"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - 文件不存在"
        exit 1
    fi
done

echo ""
echo "🔧 检查配置文件内容..."

# 检查 template.yaml
echo "📋 验证 template.yaml..."
if grep -q "OPENROUTER_API_KEY" template.yaml; then
    echo "✅ template.yaml 包含 OPENROUTER_API_KEY 配置"
else
    echo "❌ template.yaml 缺少 OPENROUTER_API_KEY 配置"
    exit 1
fi

if grep -q "ghcr.io/mendableai/firecrawl:latest" template.yaml; then
    echo "✅ template.yaml 使用正确的 Docker 镜像"
else
    echo "❌ template.yaml Docker 镜像配置错误"
    exit 1
fi

# 检查 zeabur.json
echo "📋 验证 zeabur.json..."
if grep -q "OPENROUTER_API_KEY" zeabur.json; then
    echo "✅ zeabur.json 包含 OPENROUTER_API_KEY 配置"
else
    echo "❌ zeabur.json 缺少 OPENROUTER_API_KEY 配置"
    exit 1
fi

if grep -q "openrouter.ai/api/v1" zeabur.json; then
    echo "✅ zeabur.json 配置了正确的 OpenRouter API 端点"
else
    echo "❌ zeabur.json OpenRouter API 端点配置错误"
    exit 1
fi

# 检查 package.json
echo "📋 验证 package.json..."
if grep -q "@openrouter/ai-sdk-provider" apps/api/package.json; then
    echo "✅ package.json 包含 OpenRouter SDK 依赖"
else
    echo "❌ package.json 缺少 OpenRouter SDK 依赖"
    exit 1
fi

if grep -q "build:zeabur" apps/api/package.json; then
    echo "✅ package.json 包含 Zeabur 构建脚本"
else
    echo "❌ package.json 缺少 Zeabur 构建脚本"
    exit 1
fi

# 检查环境变量示例
echo "📋 验证 .env.zeabur..."
if grep -q "OPENROUTER_API_KEY" .env.zeabur; then
    echo "✅ .env.zeabur 包含 OPENROUTER_API_KEY 示例"
else
    echo "❌ .env.zeabur 缺少 OPENROUTER_API_KEY 示例"
    exit 1
fi

echo ""
echo "🎯 检查服务配置..."

# 检查服务定义
services=("api" "worker" "redis" "playwright-service")
for service in "${services[@]}"; do
    if grep -q "$service" template.yaml && grep -q "$service" zeabur.json; then
        echo "✅ 服务 $service 在两个配置文件中都有定义"
    else
        echo "❌ 服务 $service 配置不完整"
        exit 1
    fi
done

echo ""
echo "🔗 检查端口配置..."
if grep -q "port: 3002" template.yaml && grep -q "\"port\": 3002" zeabur.json; then
    echo "✅ API 服务端口配置一致 (3002)"
else
    echo "❌ API 服务端口配置不一致"
    exit 1
fi

if grep -q "port: 3000" template.yaml && grep -q "\"port\": 3000" zeabur.json; then
    echo "✅ Playwright 服务端口配置一致 (3000)"
else
    echo "❌ Playwright 服务端口配置不一致"
    exit 1
fi

echo ""
echo "🎉 所有配置验证通过！"
echo ""
echo "📚 部署说明:"
echo "1. 获取 OpenRouter API Key: https://openrouter.ai/"
echo "2. 在 Zeabur 中导入此项目"
echo "3. 设置环境变量 OPENROUTER_API_KEY"
echo "4. 点击部署按钮"
echo ""
echo "🔧 测试部署: ./test-deployment.sh <YOUR_ZEABUR_URL>"
echo "📖 详细文档: README-ZEABUR.md"