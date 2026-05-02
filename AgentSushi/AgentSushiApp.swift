import AppKit
import SwiftUI

@main
struct AgentSushiApp: App {
    private let audioPlayer = AudioPlayer()

    var body: some Scene {
        WindowGroup {
            let notification = NotificationLoader.loadCurrentNotification()
            let content = DisplayContent.from(notification: notification)

            ContentView(content: content, closeAction: closeNow)
                .onAppear {
                    configureWindow()
                    audioPlayer.playJingle(onFinish: closeNow)
                }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }

    private func configureWindow() {
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
        }
    }

    private func closeNow() {
        NSApp.terminate(nil)
    }
}
