import Foundation

final class NotificationLoader {
    private static let fallback: TaskNotification = .high

    static func loadCurrentNotification() -> TaskNotification {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let path = "\(home)/.agent-sushi/current.json"
        let fileURL = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: fileURL) else {
            return self.fallback
        }

        return (try? JSONDecoder().decode(TaskNotification.self, from: data)) ?? self.fallback
    }
}
