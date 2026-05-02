# Agent Sushi

## Install (Homebrew Cask)

```bash
brew tap kmatsushita1012/agent-sushi-notifier
brew install --cask agent-sushi
```

## One-liner Install (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/kmatsushita1012/homebrew-agent-sushi-notifier/main/install.sh | bash
```

## Usage

```bash
agent-sushi activate
agent-sushi deactivate
```

## Release Packaging

```bash
./scripts/package_release.sh 0.1.1
```
