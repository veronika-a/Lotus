import UIKit

class HiddenTreasuresVC: UIViewController {

  @IBOutlet weak private var element1: UIImageView?
  @IBOutlet weak private var element2: UIImageView?
  @IBOutlet weak private var element3: UIImageView?
  @IBOutlet weak private var element4: UIImageView?
  @IBOutlet weak private var element5: UIImageView?
  @IBOutlet weak private var element6: UIImageView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populate()
  }
  
  private func populate() {
    element1?.image = !UserDefaultsHelper.shared.element1 ? UIImage(named: "lock") :  UIImage(named: "element-1")
    element2?.image = !UserDefaultsHelper.shared.element2 ? UIImage(named: "lock") :  UIImage(named: "element-2")
    element3?.image = !UserDefaultsHelper.shared.element3 ? UIImage(named: "lock") :  UIImage(named: "element-3")
    element4?.image = !UserDefaultsHelper.shared.element4 ? UIImage(named: "lock") :  UIImage(named: "element-4")
    element5?.image = !UserDefaultsHelper.shared.element5 ? UIImage(named: "lock") :  UIImage(named: "element-5")
    element6?.image = !UserDefaultsHelper.shared.element6 ? UIImage(named: "lock") :  UIImage(named: "element-6")
  }
  
  @IBAction func back(_ sender: Any) {
    dismiss(animated: true)
  }
}

