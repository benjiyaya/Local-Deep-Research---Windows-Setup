# Local Deep Research - Windows Setup Guide

> Quick installation and run guide for Windows

---

## Prerequisites

### 1. Python 3.10+
```
https://www.python.org/downloads/
```
⚠️ Check "Add Python to PATH" during installation!

### 2. Docker Desktop
```
https://www.docker.com/products/docker-desktop/
```
Install & restart. Make sure Docker is running (whale icon in system tray).

### 3. Ollama
```
https://ollama.ai
```
Install and run. It runs in the background on port 11434.

---

## One-Click Setup

1. Download `setup-ldr.bat`
2. Double-click to run
3. Follow the prompts

The script will:
- Check all prerequisites
- Create a project folder
- Set up a Python virtual environment
- Install LDR
- Start SearXNG search engine
- Help you download an Ollama model
- Generate a quick-start script

---

## What Gets Installed

```
local-deep-research\
├── venv\              ← Isolated Python environment
├── setup-ldr.bat      ← Installer (run once)
└── start-ldr.bat      ← Quick launch (run anytime)
```

---

## How to Run

### First time
```
Double-click setup-ldr.bat
```

### Every time after
```
Double-click start-ldr.bat
```

Then open your browser:
```
http://localhost:5000
```

---

## URLs

| Service | URL |
|---------|-----|
| LDR Web UI | http://localhost:5000 |
| SearXNG | http://localhost:8080 |
| Ollama | http://localhost:11434 |

---

## Model Options

| Model | Size | RAM Needed |
|-------|------|------------|
| qwen3:8b | ~5GB | 8GB+ |
| qwen3:14b | ~9GB | 12GB+ |
| qwen3:32b | ~20GB | 16GB+ |
| gemma3:12b | ~8GB | 12GB+ |
| llama3.1:8b | ~5GB | 8GB+ |

---

## Skip Encryption

The setup script sets this automatically:
```
LDR_BOOTSTRAP_ALLOW_UNENCRYPTED=true
```
No SQLCipher compilation needed for local-only use.

---

## System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| OS | Windows 10/11 | Windows 11 |
| RAM | 8GB | 16GB+ |
| Storage | 10GB free | 20GB+ free |
| Internet | Required for setup | Not needed after |

---

## Troubleshooting

**Python not found?**
- Reinstall Python, check "Add Python to PATH"

**Docker error?**
- Make sure Docker Desktop is running

**Ollama model download failed?**
- Pull manually: `ollama pull qwen3:8b`

**Port already in use?**
- Stop the conflicting service or change the port

---

*For video tutorial, see YouTube link in description*
