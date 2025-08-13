#!/bin/bash

# Firecrawl Zeabur 部署测试脚本
# 使用方法: ./test-deployment.sh https://your-app.zeabur.app

set -e

# 检查参数
if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "🔥 Firecrawl Zeabur 部署测试脚本"
    echo "使用方法: $0 <ZEABUR_APP_URL>"
    echo "示例: $0 https://your-app.zeabur.app"
    echo ""
    echo "可选环境变量:"
    echo "  BULL_AUTH_KEY - 管理面板认证密钥"
    exit 0
fi

BASE_URL="$1"
echo "🚀 开始测试 Firecrawl 部署: $BASE_URL"
echo ""

# 测试健康检查
echo "📡 测试健康检查..."
if curl -s -f "$BASE_URL/health" > /dev/null; then
    echo "✅ 健康检查通过"
else
    echo "❌ 健康检查失败"
    exit 1
fi

# 测试基本抓取功能
echo "🕷️ 测试基本抓取功能..."
RESPONSE=$(curl -s -X POST "$BASE_URL/v1/scrape" \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://example.com",
      "formats": ["markdown"]
    }' || echo "ERROR")

if [[ "$RESPONSE" == "ERROR" ]] || [[ "$RESPONSE" == *"error"* ]]; then
    echo "❌ 抓取功能测试失败"
    echo "响应: $RESPONSE"
    exit 1
else
    echo "✅ 抓取功能正常"
fi

# 测试爬取功能
echo "🔍 测试爬取功能..."
CRAWL_RESPONSE=$(curl -s -X POST "$BASE_URL/v1/crawl" \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://example.com",
      "limit": 1,
      "scrapeOptions": {
        "formats": ["markdown"]
      }
    }' || echo "ERROR")

if [[ "$CRAWL_RESPONSE" == "ERROR" ]] || [[ "$CRAWL_RESPONSE" == *"error"* ]]; then
    echo "❌ 爬取功能测试失败"
    echo "响应: $CRAWL_RESPONSE"
else
    echo "✅ 爬取功能正常"
fi

# 测试管理面板（如果提供了认证密钥）
if [ ! -z "$BULL_AUTH_KEY" ]; then
    echo "🎛️ 测试管理面板..."
    if curl -s -f "$BASE_URL/admin/$BULL_AUTH_KEY/queues" > /dev/null; then
        echo "✅ 管理面板可访问"
    else
        echo "⚠️ 管理面板无法访问（可能需要设置 BULL_AUTH_KEY 环境变量）"
    fi
else
    echo "ℹ️ 跳过管理面板测试（未设置 BULL_AUTH_KEY）"
fi

echo ""
echo "🎉 Firecrawl 部署测试完成！"
echo ""
echo "📚 API 端点:"
echo "  - 抓取: POST $BASE_URL/v1/scrape"
echo "  - 爬取: POST $BASE_URL/v1/crawl"
echo "  - 映射: POST $BASE_URL/v1/map"
echo "  - 搜索: POST $BASE_URL/v1/search"
echo ""
echo "🎛️ 管理面板: $BASE_URL/admin/{BULL_AUTH_KEY}/queues"
echo ""
echo "📖 详细文档: https://docs.firecrawl.dev"