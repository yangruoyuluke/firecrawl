# 🔥 Firecrawl - Zeabur 一键部署指南

本项目已经配置好可以在 [Zeabur](https://zeabur.com) 上一键部署，使用 OpenRouter API 作为 AI 服务提供商。

## 🚀 一键部署

[![Deploy on Zeabur](https://zeabur.com/button.svg)](https://zeabur.com/templates)

## 📋 部署前准备

### 1. 获取 OpenRouter API Key

1. 访问 [OpenRouter](https://openrouter.ai/)
2. 注册账户并登录
3. 在 API Keys 页面创建新的 API Key
4. 复制 API Key 备用

### 2. 部署步骤

1. 点击上方的 "Deploy on Zeabur" 按钮
2. 选择从 GitHub 导入项目
3. 输入项目 URL: `https://github.com/yangruoyuluke/firecrawl`
4. 在环境变量中设置以下必需变量：

```bash
OPENROUTER_API_KEY=your_openrouter_api_key_here
```

### 3. 可选环境变量

```bash
# 自定义模型（默认: openai/gpt-4o-mini）
MODEL_NAME=openai/gpt-4o

# 网站信息（用于 OpenRouter 排名）
HTTP_REFERER=https://your-site.com
X_TITLE=Your Site Name

# 管理面板密钥（默认: firecrawl-admin）
BULL_AUTH_KEY=your-custom-admin-key
```

## 🎯 功能特性

- ✅ **完整的 Firecrawl API**: 支持 scrape、crawl、map、search、extract 等所有功能
- ✅ **Web 用户界面**: 提供友好的 Web 界面进行网页抓取和爬取
- ✅ **OpenRouter 集成**: 使用 OpenRouter API 访问多种 AI 模型
- ✅ **自动扩缩容**: Zeabur 自动根据负载调整资源
- ✅ **内置 Redis**: 包含 Redis 缓存服务
- ✅ **Playwright 支持**: 支持动态内容抓取
- ✅ **管理面板**: 内置队列管理界面

## 🔧 支持的 AI 模型

通过 OpenRouter，您可以使用以下模型：

- **OpenAI**: gpt-4o, gpt-4o-mini, gpt-3.5-turbo
- **Anthropic**: claude-3-opus, claude-3-sonnet, claude-3-haiku
- **Google**: gemini-pro, gemini-pro-vision
- **Meta**: llama-2-70b, llama-2-13b
- **Mistral**: mistral-7b, mistral-medium
- 以及更多模型...

## 📡 API 使用示例

部署完成后，您可以通过以下方式使用 API：

### 抓取单个页面

```bash
curl -X POST https://your-app.zeabur.app/v1/scrape \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://example.com",
      "formats": ["markdown", "html"]
    }'
```

### 爬取整个网站

```bash
curl -X POST https://your-app.zeabur.app/v1/crawl \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://example.com",
      "limit": 10,
      "scrapeOptions": {
        "formats": ["markdown"]
      }
    }'
```

### AI 数据提取

```bash
curl -X POST https://your-app.zeabur.app/v1/scrape \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://example.com",
      "formats": ["json"],
      "jsonOptions": {
        "schema": {
          "type": "object",
          "properties": {
            "title": {"type": "string"},
            "description": {"type": "string"}
          }
        }
      }
    }'
```

## 🌐 Web 界面

部署完成后，您可以通过以下方式访问：

### 用户界面
访问 `https://your-ui-app.zeabur.app` 使用友好的 Web 界面进行网页抓取和爬取。

### 管理面板
访问 `https://your-api-app.zeabur.app/admin/{BULL_AUTH_KEY}/queues` 查看队列状态和任务管理。

### API 端点
直接访问 `https://your-api-app.zeabur.app/v1/` 使用 REST API。

## 💰 成本优化

- **按需付费**: Zeabur 按实际使用量计费
- **OpenRouter**: 相比直接使用 OpenAI API 更具成本效益
- **智能缓存**: 内置 Redis 缓存减少重复请求

## 🔍 故障排除

### 常见问题

1. **API Key 错误**: 确保 `OPENROUTER_API_KEY` 设置正确
2. **模型不可用**: 检查 OpenRouter 支持的模型列表
3. **内存不足**: 在 Zeabur 控制台调整服务资源配置

### 查看日志

在 Zeabur 控制台的服务页面可以查看实时日志。

## 📚 更多资源

- [Firecrawl 官方文档](https://docs.firecrawl.dev)
- [OpenRouter 文档](https://openrouter.ai/docs)
- [Zeabur 文档](https://zeabur.com/docs)

## 🤝 支持

如有问题，请：

1. 查看 [Firecrawl GitHub Issues](https://github.com/mendableai/firecrawl/issues)
2. 加入 [Firecrawl Discord](https://discord.gg/gSmWdAkdwd)
3. 联系 [Zeabur 支持](https://zeabur.com/docs)

---

**享受您的 Firecrawl 部署！** 🎉