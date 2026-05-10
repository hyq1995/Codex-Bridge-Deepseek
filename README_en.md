# CodexBridge

A lightweight proxy that brings DeepSeek and MiniMax support to [OpenAI Codex CLI](https://github.com/openai/codex), built on top of [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) with targeted fixes.

## What This Solves

Codex CLI speaks the OpenAI Responses API, while DeepSeek / MiniMax speak Chat Completions. This proxy translates between the two and fixes several compatibility issues:

- `reasoning_content` carry-over in multi-turn DeepSeek conversations
- Parallel tool_calls merging (Responses API → Chat Completions message ordering)
- Model name suffix parsing (`()` and `[]` formats)

## Supported Models

| Provider | Models | Context |
|----------|--------|---------|
| DeepSeek | `deepseek-v4-pro`, `deepseek-v4-flash` | 1M |
| MiniMax | `MiniMax-M2.7` | 204K |

## Quick Start

### Run Pre-built Binary

```bash
./cli-proxy-api --config config.yaml
```

### Build from Project ZIP

```bash
unzip CLIProxyAPI.zip -d CLIProxyAPI
cd CLIProxyAPI
go build -o ../cli-proxy-api ./cmd/server/
```

### Docker

```bash
docker compose up -d
```

## Configuration

1. Copy config template: `cp config.example.yaml config.yaml`
2. Edit `config.yaml`, fill in your API Key
3. For Docker deployment, change `host` to `0.0.0.0`

## Configure Codex CLI

Recommended: use [CC-Switch](https://github.com/Zhang161215/cc-switch) for one-click setup:

1. Download [CC-Switch](https://github.com/Zhang161215/cc-switch)
2. Select the "Codex" group, click + to add a config
3. Choose "Custom Provider", fill in:
   - API URL: `http://127.0.0.1:8787/v1`
   - API Key: `anything` (local proxy needs no real key)
4. Click Enable, then run `codex` in terminal to verify

For manual setup, edit `~/.codex/config.toml`:

```toml
model = "deepseek-v4-pro"
model_context_window = 1000000
base_url = "http://127.0.0.1:8787/v1"
```

## Acknowledgements

Built on [CLIProxyAPI](https://github.com/router-for-me/CLIProxyAPI) by [Luis Pater](https://github.com/luispater) and the [Router-For.ME](https://github.com/router-for-me) team.

## License

[MIT](LICENSE)