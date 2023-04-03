import UIKit
import GameKit

class FinishViewController: UIViewController {
  
  @IBOutlet weak var bgImage: UIImageView!
  @IBOutlet weak var exitButton: UIButton!
  @IBOutlet weak var statusImg: UIImageView!
  @IBOutlet weak var musicButton: UIButton!
  
  var isWinning: Bool = false

  private var isMuted = UserDefaultsHelper.shared.isMuted {
    didSet {
      DispatchQueue.main.async { [self] in
        if isMuted {
          musicButton.setBackgroundImage(UIImage(named: "SoundOff"), for: .normal)
          SoundManager.shared.stopMusic()
        } else {
          musicButton.setBackgroundImage(UIImage(named: "SoundOn"), for: .normal)
          SoundManager.shared.playBackgroundMusic()
        }
        UserDefaultsHelper.shared.isMuted = isMuted
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populate()
    isMuted = UserDefaultsHelper.shared.isMuted
  }
  
  private func populate() {
    switch isWinning {
      case true:
        bgImage.image = UIImage(named: "bg2")
        statusImg.image = UIImage(named: "win")
        exitButton.setBackgroundImage(UIImage(named: "right"), for: .normal)
      case false:
        bgImage.image = UIImage(named: "bg3")
        statusImg.image = UIImage(named: "lose")
        exitButton.setBackgroundImage(UIImage(named: "btn"), for: .normal)
    }
  }
  
  @IBAction func tryAgain(_ sender: Any) {
    if !isWinning {
      if let vc = navigationController?.viewControllers.filter({$0.isKind(of: GameViewController.self)}).first {
        navigationController?.popToViewController(vc, animated: true)
      }
    } else {
      if let vc = navigationController?.viewControllers.filter({$0.isKind(of: LevelViewController.self)}).first {
        navigationController?.popToViewController(vc, animated: true)
      }
    }
  }
  
  @IBAction func home(_ sender: Any) {
    if let vc = navigationController?.viewControllers.filter({$0.isKind(of: InitViewController.self)}).first {
      navigationController?.popToViewController(vc, animated: true)
    }
  }
  
  @IBAction func back(_ sender: Any) {
    if let vc = navigationController?.viewControllers.filter({$0.isKind(of: GameViewController.self)}).first {
      navigationController?.popToViewController(vc, animated: true)
    }
  }
}

