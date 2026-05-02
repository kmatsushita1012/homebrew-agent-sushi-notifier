import AppKit
import SwiftUI

@main
struct AgentSushiApp: App {
    private let audioPlayer = AudioPlayer()
    private let displayDuration: TimeInterval = 4.0

    var body: some Scene {
        WindowGroup {
            let notification = NotificationLoader.loadCurrentNotification()
            let content = DisplayContent.from(notification: notification)

            ContentView(content: content)
                .onAppear {
                    audioPlayer.playJingle()
                    configureWindowAndAutoClose()
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }

    private func configureWindowAndAutoClose() {
        DispatchQueue.main.async {
            guard let window = NSApp.windows.first else { return }
            window.level = .statusBar
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
            window.styleMask.remove(.titled)
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true

            if let screen = NSScreen.main {
                window.setFrame(screen.frame, display: true)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
                NSApp.terminate(nil)
            }
        }
    }
}
