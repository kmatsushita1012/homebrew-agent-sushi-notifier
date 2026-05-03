import Foundation

final class NotificationLoader {
//    private static let fallback: TaskNotification = .fallback

    static func loadCurrentNotification() -> TaskNotification {
        let home = FileManager.default.homeDirectoryForCurrentUser.path
        let path = "\(home)/.agent-sushi/current.json"
        let fileURL = URL(fileURLWithPath: path)

        guard let data = try? Data(contentsOf: fileURL) else {
            return .fallback(message: "Data not found at \(path)")
        }

        return (try? JSONDecoder().decode(TaskNotification.self, from: data)) ?? .fallback(message: "JSON decoding failed")
    }
}
