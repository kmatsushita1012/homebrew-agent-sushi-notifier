# 🍣 Agent Sushi

## Introduction (JA)

回転寿司でタッチパネルを操作していると、  
突然「ご注文の品、まもなく到着します」って出てくる、あのちょっとイラっとする瞬間。

それをそのまま **AIエージェントに持ち込みました。**

---

タスクが完了すると、全画面で寿司が“到着”。

- 商品名の代わりに **あなたのプロンプト**
- モデルの性能に応じて **ネタが変わる（大トロ / 中トロ / 赤身）**
- 無駄に本格的な“それっぽい”到着演出

---

実用性はほぼありません。  
**面白さと無駄な没入感だけを全力で追求したツールです。**

---

## Introduction (EN)

If you’ve ever been to a conveyor belt sushi restaurant in Japan,  
you probably remember that moment:

You’re tapping through the menu, and suddenly  
“Your order is arriving” pops up on the screen —  
slightly annoying, slightly amusing.

So… we gave that experience to your AI agent.

---

When a task completes, sushi *arrives* in full screen.

- Your **prompt becomes the dish name**
- The sushi changes based on model quality  
  *(Otoro / Chutoro / Akami)*
- Unnecessarily faithful “that exact feeling” arrival animation

---

There is basically no practical value.

**This exists purely for fun and mildly immersive chaos.**

## Install (Homebrew Cask)

```bash
brew tap kmatsushita1012/agent-sushi
brew install --cask agent-sushi
```

## One-liner Install (curl)

```bash
curl -fsSL https://raw.githubusercontent.com/kmatsushita1012/agent-sushi/main/install.sh | bash
```

## Usage

```bash
agent-sushi activate
agent-sushi deactivate
```

`activate` は以下を設定します。
- Codex: `~/.codex/config.toml` のトップレベル `notify`
- Claude: `~/.claude/settings.json` が存在する場合のみ `hooks.Stop` に command hook を追加

`activate` configures:
- Codex: top-level `notify` in `~/.codex/config.toml`
- Claude: adds a command hook to `hooks.Stop` only if `~/.claude/settings.json` exists
- Notification launch: best-effort focus to Codex before opening `SushiArrived`

## 対応環境

- Codex: 動作確認済み
- Claude: 実装は追加済みですが、オーナーがClaude未契約のため未検証です。動作確認してPRをくださる方を募集しています。

## Supported Environments

- Codex: verified
- Claude: implementation has been added, but not yet verified because the owner does not have a Claude subscription. PRs for verification are welcome.

## Release Packaging

```bash
./scripts/package_release.sh 0.1.1
```
