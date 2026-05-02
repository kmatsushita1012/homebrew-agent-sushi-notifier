import AppKit
import SwiftUI

@main
struct AgentSushiApp: App {
    private let audioPlayer = AudioPlayer()
    private let escHandler = EscapeKeyHandler()

    var body: some Scene {
        WindowGroup {
            let notification = NotificationLoader.loadCurrentNotification()
            let content = DisplayContent.from(notification: notification)

            ContentView(content: content, closeAction: closeNow)
                .onAppear {
                    configureWindow()
                    escHandler.start(closeAction: closeNow)
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
        escHandler.stop()
        NSApp.terminate(nil)
    }
}

final class EscapeKeyHandler {
    private var monitor: Any?

    func start(closeAction: @escaping () -> Void) {
        stop()
        monitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
            if event.keyCode == 53 { // Esc
                closeAction()
                return nil
            }
            return event
        }
    }

    func stop() {
        if let monitor {
            NSEvent.removeMonitor(monitor)
            self.monitor = nil
        }
    }
}
