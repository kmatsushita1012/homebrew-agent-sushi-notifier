import Foundation

final class NotificationLoader {
    private static let fallback: TaskNotification = .high

    static func loadCurrentNotification() -> TaskNotification {
        let path = NSString(string: "~/.sushi-arrived/current.json").expandingTildeInPath
        let fileURL = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: fileURL) else {
            return self.fallback
        }

        return (try? JSONDecoder().decode(TaskNotification.self, from: data)) ?? self.fallback
    }
}
