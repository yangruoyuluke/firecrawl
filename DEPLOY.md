# 🚀 Firecrawl Zeabur 部署指南

本项目已完全配置好，可以在 Zeabur 上一键部署！

## ✅ 已完成的配置

### 1. OpenRouter API 集成
- ✅ 修改了 `apps/api/src/lib/LLM-extraction/generic-ai.ts` 支持 OpenRouter
- ✅ 默认使用 OpenRouter API (`https://openrouter.ai/api/v1`)
- ✅ 支持 `OPENROUTER_API_KEY` 环境变量
- ✅ 默认模型设置为 `openai/gpt-4o-mini`

### 2. Zeabur 部署文件
- ✅ `template.yaml` - Zeabur 模板配置
- ✅ `zeabur.json` - 服务配置
- ✅ `.env.zeabur` - 环境变量示例
- ✅ `Dockerfile.zeabur` - 优化的 Docker 构建文件
- ✅ `README-ZEABUR.md` - 详细部署说明

### 3. 服务架构
- ✅ API 服务 (主应用)
- ✅ Worker 服务 (后台任务处理)
- ✅ Redis 服务 (缓存和队列)
- ✅ Playwright 服务 (动态内容抓取)

## 🎯 一键部署步骤

### 方法 1: 使用 Zeabur 模板 (推荐)

1. 访问 [Zeabur Templates](https://zeabur.com/templates)
2. 搜索 "Firecrawl" 或导入此项目
3. 设置环境变量：
   ```
   OPENROUTER_API_KEY=your_openrouter_api_key_here
   ```
4. 点击部署！

### 方法 2: 从 GitHub 导入

1. 在 Zeabur 控制台选择 "从 GitHub 导入"
2. 输入仓库 URL: `https://github.com/yangruoyuluke/firecrawl`
3. Zeabur 会自动识别 `template.yaml` 并配置服务
4. 设置必需的环境变量
5. 部署完成！

## 🔑 必需的环境变量

```bash
# 必需 - OpenRouter API Key
OPENROUTER_API_KEY=your_openrouter_api_key_here

# 可选 - 自定义模型
MODEL_NAME=openai/gpt-4o-mini

# 可选 - 管理面板密钥
BULL_AUTH_KEY=firecrawl-admin

# 可选 - 网站信息（用于 OpenRouter 排名）
HTTP_REFERER=https://your-site.com
X_TITLE=Your Site Name
```

## 🧪 测试部署

部署完成后，测试 API：

```bash
# 替换 your-app.zeabur.app 为你的实际域名
curl -X POST https://your-app.zeabur.app/v1/scrape \
    -H 'Content-Type: application/json' \
    -d '{
      "url": "https://example.com",
      "formats": ["markdown"]
    }'
```

## 🎛️ 管理面板

访问: `https://your-app.zeabur.app/admin/{BULL_AUTH_KEY}/queues`

## 📊 支持的 AI 模型

通过 OpenRouter 可使用：
- OpenAI: gpt-4o, gpt-4o-mini, gpt-3.5-turbo
- Anthropic: claude-3-opus, claude-3-sonnet, claude-3-haiku
- Google: gemini-pro, gemini-pro-vision
- Meta: llama-2-70b, llama-2-13b
- 以及更多...

## 🔧 故障排除

1. **API Key 错误**: 确保在 Zeabur 环境变量中正确设置了 `OPENROUTER_API_KEY`
2. **服务启动失败**: 检查 Zeabur 控制台的日志
3. **内存不足**: 在 Zeabur 控制台调整服务资源配置

## 📚 API 文档

详细的 API 使用说明请参考：
- [README-ZEABUR.md](./README-ZEABUR.md)
- [Firecrawl 官方文档](https://docs.firecrawl.dev)

---

**🎉 现在您可以直接在 Zeabur 上一键部署 Firecrawl 了！**