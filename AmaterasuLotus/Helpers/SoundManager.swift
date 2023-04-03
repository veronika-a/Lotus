import SpriteKit
import AVFAudio

class SoundManager {
  static let shared = SoundManager()
  var player = AVAudioPlayer()
  var soundPlayer = AVAudioPlayer()
  
  func playBackgroundMusic() {
    guard let path = Bundle.main.path(forResource: "course-of-nature.wav", ofType: nil) else { return }
    let url = URL(fileURLWithPath: path)
    do {
      self.player = try AVAudioPlayer(contentsOf: url)
      self.player.numberOfLoops = -1
      self.player.volume = 0.1
      self.player.play()
    } catch {
      print("no sound")
    }
  }
  
  func playSound(name: String) {
    if !UserDefaultsHelper.shared.isMutedSound {
      let path = Bundle.main.path(forResource: name, ofType: nil)!
      let url = URL(fileURLWithPath: path)
      do {
        self.soundPlayer = try AVAudioPlayer(contentsOf: url)
        self.soundPlayer.volume = 0.1
        self.soundPlayer.play()
      } catch {
        print("no sound")
      }
    }
  }
  
  func stopSound() {
    soundPlayer.stop()
  }
  
  func stopMusic() {
    player.stop()
  }
}
