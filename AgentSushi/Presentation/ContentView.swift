import SwiftUI

struct ContentView: View {
    let content: DisplayContent
    let closeAction: () -> Void

    var body: some View {
        Group {
            if AppLanguage.current == .ja {
                ContentViewJA(content: content, closeAction: closeAction)
            } else {
                ContentViewEN(content: content, closeAction: closeAction)
            }
        }
        .onExitCommand(perform: closeAction)
    }
}

private struct ContentViewJA: View {
    let content: DisplayContent
    let closeAction: () -> Void
    private let bottomTextPositionXRatio: CGFloat = 0.50
    private let bottomTextPositionYRatio: CGFloat = 0.73
    private let closeButtonPositionXRatio: CGFloat = 0.73
    private let closeButtonTextPositionYRatio: CGFloat = 0.17

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(content.modelImageName).resizable().scaledToFill().ignoresSafeArea()
                Button(action: closeAction) {
                    // 意図的に Button(titleKey, action)を使わずに label: を使っている
                    Text("閉じる")
                        .font(.system(size: 36).weight(.semibold))
                        .foregroundStyle(.text)
                        .padding()
                }
                .buttonStyle(.bordered)
                .position(x: proxy.size.width * closeButtonPositionXRatio, y: proxy.size.height * closeButtonTextPositionYRatio)
                Text(content.bottomText)
                    .font(.system(size: 48).weight(.semibold))
                    .foregroundStyle(.text)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(width: proxy.size.width * 0.72)
                    .position(x: proxy.size.width * bottomTextPositionXRatio, y: proxy.size.height * bottomTextPositionYRatio)
            }
        }
    }
}

private struct ContentViewEN: View {
    let content: DisplayContent
    let closeAction: () -> Void
    private let bottomTextPositionXRatio: CGFloat = 0.48
    private let bottomTextPositionYRatio: CGFloat = 0.78
    private let closeButtonPositionXRatio: CGFloat = 0.73
    private let closeButtonTextPositionYRatio: CGFloat = 0.17

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Image(content.modelImageName).resizable().scaledToFill().ignoresSafeArea()
                Button(action: closeAction) {
                    // 意図的に Button(titleKey, action)を使わずに label: を使っている
                    Text("Close")
                        .font(.system(size: 36).weight(.semibold))
                        .foregroundStyle(.text)
                        .padding()
                }
                .buttonStyle(.bordered)
                .position(x: proxy.size.width * closeButtonPositionXRatio, y: proxy.size.height * closeButtonTextPositionYRatio)
                Text(content.bottomText)
                    .font(.system(size: 48).weight(.semibold))
                    .foregroundStyle(.text)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(width: proxy.size.width * 0.72)
                    .position(x: proxy.size.width * bottomTextPositionXRatio, y: proxy.size.height * bottomTextPositionYRatio)
            }
        }
    }
}

//#Preview("JA High") {
//    ContentView(content: DisplayContent.from(notification: .high, language: .ja), closeAction: {})
//        .frame(width: 1512, height: 982)
//}
//
//#Preview("EN Middle") {
//    ContentView(content: DisplayContent.from(notification: .middle, language: .en), closeAction: {})
//        .frame(width: 1512, height: 982)
//}
