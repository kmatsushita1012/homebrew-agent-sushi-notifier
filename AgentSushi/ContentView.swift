import AVFoundation
import SwiftUI

struct TaskNotification: Codable {
    let title: String
    let model: String
}

enum SushiTier {
    case high
    case middle
    case low

    init(model: String) {
        let normalized = model.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if ["opus", "gpt-5", "o1", "sonnet-4", "claude-opus"].contains(where: normalized.contains) {
            self = .high
        } else if ["sonnet", "gpt-4.1", "o3"].contains(where: normalized.contains) {
            self = .middle
        } else {
            self = .low
        }
    }

    var imageName: String {
        switch self {
        case .high: "model-high"
        case .middle: "model-middle"
        case .low: "model-low"
        }
    }
}

struct DisplayContent {
    let bottomText: String
    let modelImageName: String

    static func from(notification: TaskNotification) -> DisplayContent {
        let tier = SushiTier(model: notification.model)
        let trimmedTitle = truncatedTaskTitle(notification.title, maxCount: 10)
        return DisplayContent(
            bottomText: "「\(trimmedTitle)」が完了しました",
            modelImageName: tier.imageName
        )
    }

    private static func truncatedTaskTitle(_ title: String, maxCount: Int) -> String {
        let normalized = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalized.count > maxCount else { return normalized }
        return String(normalized.prefix(maxCount)) + "..."
    }
}

final class NotificationLoader {
    static func loadCurrentNotification() -> TaskNotification {
        let fallback = TaskNotification(title: "ログイン実装を終わらせてほしい", model: "gpt-5")
        let path = NSString(string: "~/.sushi-arrived/current.json").expandingTildeInPath
        let fileURL = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: fileURL) else {
            return fallback
        }

        return (try? JSONDecoder().decode(TaskNotification.self, from: data)) ?? fallback
    }
}

final class AudioPlayer {
    private var player: AVAudioPlayer?

    func playJingle() {
        guard let url = Bundle.main.url(forResource: "soft-003", withExtension: "mp3", subdirectory: "Resources/Audio")
              ?? Bundle.main.url(forResource: "soft-003", withExtension: "mp3") else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            // 音声再生失敗時もUI表示は継続する
        }
    }
}

struct ContentView: View {
    let content: DisplayContent
    // 調整用: 0.0 ... 1.0 の範囲で相対位置を指定
    private let bottomTextPositionXRatio: CGFloat = 0.50
    private let bottomTextPositionYRatio: CGFloat = 0.75
    
    private let closeButtonPositionXRatio: CGFloat = 0.73
    private let closeButtonTextPositionYRatio: CGFloat = 0.17

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(content.modelImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                Button {
                    
                } label: {
                    Text("閉じる")
                        .font(.system(size: 36).weight(.semibold))
                        .foregroundStyle(.text)
                        .padding()
                }
                .buttonStyle(.bordered)
                .position(
                    x: proxy.size.width * closeButtonPositionXRatio,
                    y: proxy.size.height * closeButtonTextPositionYRatio
                )
                

                Text(content.bottomText)
                    .font(.system(size: 48).weight(.semibold))
                    .foregroundStyle(.text)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(width: proxy.size.width * 0.72)
                    .position(
                        x: proxy.size.width * bottomTextPositionXRatio,
                        y: proxy.size.height * bottomTextPositionYRatio
                    )
            }
        }
    }
}

#Preview("High Model") {
    ContentView(
        content: DisplayContent.from(
            notification: TaskNotification(title: "Authリファクタについての修正案の提案", model: "opus")
        )
    )
    .frame(width: 1512, height: 982)
}

#Preview("Middle Model") {
    ContentView(
        content: DisplayContent.from(
            notification: TaskNotification(title: "CI調整", model: "sonnet")
        )
    )
    .frame(width: 1512, height: 982)
}

#Preview("Low/Unknown Model") {
    ContentView(
        content: DisplayContent.from(
            notification: TaskNotification(title: "軽量タスク", model: "haiku")
        )
    )
    .frame(width: 1512, height: 982)
}
