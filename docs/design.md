# SushiArrived design.md

## 1. 目的
`SushiArrived.app` は「表示専用」の macOS SwiftUI アプリとして動作し、`sushi-hook` が作成した `~/.sushi-arrived/current.json` を起動時に読み込んで、回転寿司到着風の全画面通知を数秒表示して自動終了する。

---

## 2. スコープ
### 2.1 MVP対象
- 引数なし起動（`open -a SushiArrived` 前提）
- 起動時に `~/.sushi-arrived/current.json` を1回読み込み
- `title` と `model` から表示内容を決定
- 全画面オーバーレイを最前面表示（3〜5秒）
- 自動終了

### 2.2 MVP対象外
- 常駐監視
- 複数通知キュー
- 音声再生
- CLI引数対応
- Hook側ロジック（prompt保存/タイトル生成等）

---

## 3. アーキテクチャ
レイヤーを以下に分離する。

- Presentation: SwiftUI View と表示制御
- UseCase: 起動フローのオーケストレーション
- Domain: 通知データと寿司種別決定ルール
- Data: JSONファイル読み込み

依存方向は `Presentation -> UseCase -> Domain/Data`。

---

## 4. Domain設計

### 4.1 Entity
- `TaskNotification`
  - `title: String`
  - `model: String`

- `SushiGrade`
  - `.otoro`（高性能）
  - `.chutoro`（中間）
  - `.akami`（軽量/不明）

### 4.2 ルール
`model` を正規化（lowercased + trim）し、次の判定を行う。

- 高性能: `opus`, `gpt-5`, `o1`, `sonnet`上位など（将来拡張） -> `.otoro`
- 中間: `sonnet`, `gpt-4.1`, `o3` など -> `.chutoro`
- 軽量: `haiku`, `gpt-4o-mini`, `o4-mini` など -> `.akami`
- 不明: 上記に該当しない -> `.akami`

MVPでは厳密な網羅より「未知は赤身」優先。

---

## 5. Data設計

### 5.1 入力ファイル
`~/.sushi-arrived/current.json`

```json
{
  "title": "Authリファクタ",
  "model": "opus"
}
```

### 5.2 DTO
- `CurrentNotificationDTO`
  - `title: String`
  - `model: String`

### 5.3 Repository
- `NotificationRepository`
  - `func loadCurrent() throws -> TaskNotification`

実装 `FileNotificationRepository`:
1. `~/.sushi-arrived/current.json` を解決
2. UTF-8で読込
3. JSON decode
4. Domain Entityへ変換

### 5.4 エラーハンドリング
- ファイルなし / decode失敗時:
  - フォールバック表示を生成
  - `title = "タスク"`, `model = "unknown"`

アプリはクラッシュさせず必ず表示して終了する。

---

## 6. UseCase設計

### 6.1 `BuildDisplayContentUseCase`
責務: 起動時に表示用データを1つ作る。

入出力:
- Input: なし
- Output: `DisplayContent`
  - `headlineTop: String`（例: `Task Complete`）
  - `messageBottom: String`（`<title> が完了しました`）
  - `sushiGrade: SushiGrade`
  - `backgroundImageName: String`
  - `plateImageName: String`
  - `sushiImageName: String`

フロー:
1. Repositoryから通知読込
2. model -> SushiGrade 判定
3. 画像名マッピング
4. 画面文言組み立て

---

## 7. Presentation設計

### 7.1 画面構成
`NotificationOverlayView`
- 上: タスク通知ラベル
- 中: 皿画像 + 寿司画像（重ね合わせ）
- 下: `<タイトル> が完了しました`
- 背景: タッチパネル風背景画像

### 7.2 Window制御
`AppKit` ブリッジで専用 `NSWindow` を制御。
- レベル: `.statusBar` 以上で最前面
- フルスクリーン相当サイズ（対象スクリーン全体）
- タイトルバー非表示
- 背景透過なし（全面描画）

### 7.3 ライフサイクル
起動時:
1. UseCaseで `DisplayContent` 構築
2. Window表示
3. `Task.sleep` / `DispatchQueue.main.asyncAfter` で3〜5秒待機
4. `NSApp.terminate(nil)`

表示秒数は定数 `displayDuration: TimeInterval = 4.0`（MVP固定）

---

## 8. 画像アセット方針

`Assets.xcassets` に以下を登録。
- `bg_sushi_panel`
- `plate_default`
- `sushi_otoro`
- `sushi_chutoro`
- `sushi_akami`

マッピング:
- `.otoro` -> `sushi_otoro`
- `.chutoro` -> `sushi_chutoro`
- `.akami` -> `sushi_akami`

---

## 9. 実装ファイル案

- `AgentSushi/SushiArrivedApp.swift`
- `AgentSushi/Presentation/NotificationOverlayView.swift`
- `AgentSushi/Presentation/OverlayWindowController.swift`
- `AgentSushi/UseCase/BuildDisplayContentUseCase.swift`
- `AgentSushi/Domain/TaskNotification.swift`
- `AgentSushi/Domain/SushiGrade.swift`
- `AgentSushi/Data/NotificationRepository.swift`
- `AgentSushi/Data/FileNotificationRepository.swift`

既存構成に合わせて最小変更で配置する。

---

## 10. テスト観点（最小）

### 10.1 Unit Test
- model判定（高性能/中間/軽量/不明）
- JSON decode成功/失敗
- フォールバック動作

### 10.2 手動確認
- `current.json` 正常時に期待表示
- `current.json` 不在時でも表示して終了
- 起動から約4秒で終了
- 最前面表示される

---

## 11. 非機能要件
- 常駐しない（起動->表示->終了）
- 個人データ永続化なし（読み取りのみ）
- 企業ロゴ/店舗UIの直接コピー禁止

---

## 12. 将来拡張（MVP後）
- テーマ複数（朝/夜/祭り）
- アニメーション強化（回転・湯気）
- 表示秒数の設定ファイル化
- 多言語文言
