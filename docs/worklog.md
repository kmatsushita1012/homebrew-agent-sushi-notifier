# Agent Sushi 作業ログ（2026-05-03）

## 1. 実装した機能
- モデル別通知UI（`high/middle/low`）
- `ja/en` のUI分岐（`ContentViewJA` / `ContentViewEN`）
- 画像アセットの追加（`model-*-en` 含む）
- 通知時のジングル再生（`jingle.mp3`）
- `Esc` / 閉じるボタンで早期終了
- 音再生終了後の自動終了
- タスク名省略ルール（`...`）と文言整形
- `~/.sushi-arrived/current.json` 連携

## 2. データ連携の更新
- 初期実装: `~/.codex/history.jsonl` 参照
- 改善後: `~/.codex/sessions/**/rollout-*.jsonl` を参照
  - `title`: 最新ユーザー発話
  - `model`: `turn_context.payload.model`
  - `session_id`: `session_meta.payload.id`
- 保存先:
  - `~/.sushi-arrived/current.json`
  - `~/.sushi-arrived/sessions/<session_id>.json`

## 3. CLI / 配布まわり
- `agent-sushi activate`
  - hook設置
  - Codex `notify` 設定を追加
  - `SushiArrived.app` の quarantine 解除
- `agent-sushi deactivate`
  - hook削除
  - `notify` 設定削除
- `install.sh` 追加（curl導線）

## 4. Homebrew 配布
- リポジトリ名を `homebrew-agent-sushi-notifier` に統一
- Cask: `Casks/agent-sushi.rb`
- リリース更新:
  - `v0.1.0` 初期
  - `v0.1.1` UI/ロジック更新
  - `v0.1.2` 会話ログ/モデル反映
  - `v0.1.3` session別保存
  - `v0.1.4` `jingle.mp3` 反映
  - `v0.1.5` `activate` の `notify` 位置修正（トップレベル固定）

## 5. 主な不具合と対処
- Gatekeeperで「壊れている」
  - 原因: 未公証 + quarantine
  - 対処: `activate` / `install.sh` で `xattr -dr com.apple.quarantine`
- 通知が発火しない
  - 原因: `notify` がトップレベルでなくテーブル配下に配置
  - 対処: `activate` を改善し、`notify` を必ずトップレベルへ再配置
- `hello` / `low` 固定に見える
  - 原因: 旧ログ参照や既定model参照
  - 対処: `sessions rollout` から現在セッションの最新情報抽出へ変更

## 6. クリーン手順（確認済み）
1. `brew uninstall --cask agent-sushi`
2. `brew untap kmatsushita1012/agent-sushi-notifier`
3. `rm -rf ~/.sushi-arrived`
4. `~/.codex/config.toml` から `agent_sushi_notify` 関連を削除
5. 再インストール:
   - `brew tap kmatsushita1012/agent-sushi-notifier`
   - `brew install --cask agent-sushi`
   - `agent-sushi activate`

## 7. 現状の注意点
- Codex未導入PCでも `activate` 自体はクラッシュしない設計
- ただし Codex `notify` 発火元がない場合は自動通知は動作しない
- Claude連携を追加（2026-05-03）
  - 対象: `~/.claude/settings.json` が存在する場合のみ
  - `hooks.Stop` に `agent_sushi_notify` command hook を重複なしで追加
  - JSON形式不正/想定外構造の場合は安全にスキップ（クラッシュさせない）
