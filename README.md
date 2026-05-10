# CodexBridge

基于 [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) 微调修改，让 [OpenAI Codex CLI](https://github.com/openai/codex) 支持 DeepSeek、MiniMax 等 OpenAI 兼容模型。

## 解决了什么问题

Codex CLI 使用 OpenAI Responses API 协议，而 DeepSeek / MiniMax 等提供商使用 Chat Completions 协议。本项目在两者之间做协议转换，并修复了以下兼容性问题：

- DeepSeek 思考模式下 `reasoning_content` 多轮对话回传
- 并行 tool_calls 合并（Responses API → Chat Completions 消息排序）
- 模型名后缀解析（支持 `()` 和 `[]` 格式）

## 支持的模型

| 提供商 | 模型 | 上下文 |
|--------|------|--------|
| DeepSeek | `deepseek-v4-pro`、`deepseek-v4-flash` | 1M |
| MiniMax | `MiniMax-M2.7` | 204K |

## 使用方式

### 直接运行预编译二进制

下载 `cli-proxy-api` 二进制后，配置 `config.yaml` 即可运行：

```bash
./cli-proxy-api --config config.yaml
```

### 从项目压缩包(CLIProxyAPI.zip)编译

```bash
# 解压 CLIProxyAPI 源码
unzip CLIProxyAPI.zip -d CLIProxyAPI
cd CLIProxyAPI
# 进行源码微调（若需要）
# ...
go build -o ../cli-proxy-api ./cmd/server/
```

### Docker 部署

```bash
docker compose up -d
```

## 配置

1. 复制配置模板：`cp config.example.yaml config.yaml`
2. 编辑 `config.yaml`，填入你的 API Key
3. Docker 部署时需将 `host` 改为 `0.0.0.0`

## 配置 Codex CLI

推荐使用 [CC-Switch](https://github.com/Zhang161215/cc-switch) 图形化配置工具，一键管理 Codex、Claude Code、Gemini CLI 等工具的 API 配置：

1. 下载 [CC-Switch](https://github.com/Zhang161215/cc-switch)
2. 选择 "Codex" 分组，点击 + 添加配置
3. 选择自定义供应商，填入：
   - API 地址：`http://127.0.0.1:8787/v1`
   - API Key：`anything`（本地代理无需真实密钥）
4. 点击启用，在终端运行 `codex` 验证

如需手动配置，编辑 `~/.codex/config.toml`：

```toml
model = "deepseek-v4-pro"
model_context_window = 1000000
base_url = "http://127.0.0.1:8787/v1"
```

## 致谢

本项目基于 [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) 微调修改，感谢 [Luis Pater](https://github.com/luispater) 和 [Router-For.ME](https://github.com/router-for-me) 团队的工作。

## 许可

[MIT](LICENSE)
