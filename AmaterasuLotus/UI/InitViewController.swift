import UIKit
import GameKit

class InitViewController: UIViewController {
    
  @IBOutlet weak var musicButton: UIButton!
  private lazy var scene = MenuScene()

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
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    UserDefaultsHelper.shared.element1 = false
//    UserDefaultsHelper.shared.element2 = false
//    UserDefaultsHelper.shared.element3 = false
//    UserDefaultsHelper.shared.element4 = false
//    UserDefaultsHelper.shared.element5 = false
//    UserDefaultsHelper.shared.element6 = false

    isMuted = UserDefaultsHelper.shared.isMuted
    
    let skView = SKView(frame: view.bounds)
    skView.backgroundColor = .clear
    skView.isUserInteractionEnabled = false
    
    view.addSubview(skView)
    
    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    scene.scaleMode = .resizeFill
    
    skView.presentScene(scene)
  }
  
  @IBAction func startTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "level") as? LevelViewController else { return }
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @IBAction func soundTap(_ sender: Any) {
    isMuted = !isMuted
  }
  
  @IBAction func infoTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "info") as? InfoViewController else { return }
    self.present(vc, animated: true)
  }
  
  @IBAction func treasuresTap(_ sender: Any) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "treasures") as? HiddenTreasuresVC else { return }
    self.present(vc, animated: true)
  }
}

extension InitViewController: GKGameCenterControllerDelegate {
  
  func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    gameCenterViewController.dismiss(animated: true, completion: nil)
  }
}
