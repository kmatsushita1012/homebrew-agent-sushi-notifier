import AVFoundation

final class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    private var onFinish: (() -> Void)?

    func playJingle(onFinish: @escaping () -> Void) {
        self.onFinish = onFinish
        guard let url = Bundle.main.url(forResource: "jingle", withExtension: "mp3", subdirectory: "Resources/Audio")
              ?? Bundle.main.url(forResource: "jingle", withExtension: "mp3") else {
            onFinish()
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            player?.play()
        } catch {
            onFinish()
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onFinish?()
    }
}
