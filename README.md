# Codex Proxy - DeepSeek & MiniMax 接入 Codex CLI

基于 [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) 改造，让 [OpenAI Codex CLI](https://github.com/openai/codex) 支持 DeepSeek、MiniMax 等 OpenAI 兼容模型。

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

## 快速开始

### 方式一：直接运行

1. 从 [CLIProxyAPI Releases](https://github.com/router-for-me/CLIProxyAPI/releases) 下载对应平台的二进制

2. 复制配置文件并填入 API Key：

```bash
cp config.example.yaml config.yaml
# 编辑 config.yaml，填入你的 API Key
```

3. 启动：

```bash
./cli-proxy-api --config config.yaml
```

### 方式二：Docker 部署

```bash
cp config.example.yaml config.yaml
# 编辑 config.yaml：
#   1. 填入 API Key
#   2. 将 host 改为 '0.0.0.0'

docker compose up -d
```

### 方式三：从源码构建

```bash
git clone https://github.com/router-for-me/CLIProxyAPI.git
cd CLIProxyAPI
go build -o cli-proxy-api ./cmd/server/
./cli-proxy-api --config ../config.yaml
```

## 配置 Codex CLI

```bash
# 指向本地代理
export OPENAI_BASE_URL=http://127.0.0.1:8787/v1
export OPENAI_API_KEY=anything

# 使用 DeepSeek
codex -m deepseek-v4-pro

# 使用 MiniMax
codex -m MiniMax-M2.7
```

在 `~/.codex/config.toml` 中设置上下文窗口：

```toml
model = "deepseek-v4-pro"
model_context_window = 1000000
```

## 致谢

本项目基于 [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) 改造，感谢 [Luis Pater](https://github.com/luispater) 和 [Router-For.ME](https://github.com/router-for-me) 团队的出色工作。CLIProxyAPI 提供了完善的 AI CLI 工具协议转换框架，使得本项目能够专注于 DeepSeek 和 MiniMax 的兼容性适配。

## 许可

[MIT](LICENSE) — 与上游 CLIProxyAPI 保持一致。
