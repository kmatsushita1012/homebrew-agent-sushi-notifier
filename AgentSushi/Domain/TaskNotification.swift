import Foundation

struct TaskNotification: Codable {
    let title: String
    let model: String

    static let high = TaskNotification(title: "Please list the tasks for verifying high-performance models.", model: "opus")
    static let middle = TaskNotification(title: "中間モデルの確認タスクを行なってください", model: "sonnet")
    static let low = TaskNotification(title: "軽量モデルの確認タスクを行なってください", model: "haiku")
}

enum SushiTier {
    case high
    case middle
    case low

    init(model: String) {
        let normalized = model.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if normalized.contains("opus") { self = .high; return }
        if normalized.contains("haiku") { self = .low; return }
        if normalized.contains("sonnet") { self = .middle; return }
        if normalized.contains("nano") || normalized.contains("mini") { self = .low; return }

        if normalized.hasPrefix("gpt-") || normalized.contains(" gpt-") {
            if normalized.contains("codex") { self = .middle }
            else if normalized.contains("gpt-5") || normalized.contains("gpt-6") { self = .high }
            else { self = .middle }
            return
        }

        self = .low
    }
}

enum AppLanguage {
    case ja
    case en

    static var current: AppLanguage {
        let code = Locale.preferredLanguages.first?.lowercased() ?? ""
        return code.hasPrefix("ja") ? .ja : .en
    }
}

struct DisplayContent {
    let bottomText: String
    let modelImageName: String

    static func from(notification: TaskNotification, language: AppLanguage = .current) -> DisplayContent {
        let tier = SushiTier(model: notification.model)
        let hasJapanese = containsJapanese(notification.title)
        let maxCount: Int
        switch (language, hasJapanese) {
        case (.ja, true): maxCount = 10
        case (.en, true): maxCount = 13
        case (.en, false): maxCount = 30
        case (.ja, false): maxCount = 25
        }
        let trimmedTitle = truncatedTaskTitle(notification.title, maxCount: maxCount)

        let imageName: String
        switch (language, tier) {
        case (.ja, .high): imageName = "model-high"
        case (.ja, .middle): imageName = "model-middle"
        case (.ja, .low): imageName = "model-low"
        case (.en, .high): imageName = "model-high-en"
        case (.en, .middle): imageName = "model-middle-en"
        case (.en, .low): imageName = "model-low-en"
        }

        let suffix = language == .ja ? "が完了しました" : " is complete"
        return DisplayContent(
            bottomText: "\"\(trimmedTitle)\"\(suffix)",
            modelImageName: imageName
        )
    }

    private static func truncatedTaskTitle(_ title: String, maxCount: Int) -> String {
        let normalized = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard normalized.count > maxCount else { return normalized }
        return String(normalized.prefix(maxCount)) + "..."
    }

    private static func containsJapanese(_ text: String) -> Bool {
        text.unicodeScalars.contains {
            switch $0.value {
            case 0x3040...0x30FF, 0x4E00...0x9FFF:
                return true
            default:
                return false
            }
        }
    }
}
