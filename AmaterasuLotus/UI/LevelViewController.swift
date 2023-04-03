import GameKit

class LevelsCell: UITableViewCell {
  
  @IBOutlet private weak var buttonImage: UIImageView!
  @IBOutlet private weak var lockImg: UIImageView!
  @IBOutlet private weak var lockLabel: UILabel!
  @IBOutlet private weak var centerXConstaint: NSLayoutConstraint!
  
  func configer(index: IndexPath, level: Int) {
    self.selectionStyle = .none
    
    lockLabel.text = "\(index.row + 1)"
    lockLabel.isHidden = level >= index.row ? false : true
    buttonImage.clipsToBounds = true
    buttonImage.alpha = level > index.row ? 1 : (level  + 1 >= index.row ? 0.6 : 0)
    buttonImage.image = UIImage(named: "lotus")
    lockImg.alpha = index.row > level ? (level + 1 >= index.row ? 1 : 0) : 0
    
    centerXConstaint.constant = (index.row % 2 == 0) ? 88 : -88
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    contentView.alpha = selected ? 0.5 : 1
  }
}

class LevelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  let numberOfLevels = Level.Levels.allCases.count
  var bestLevel: Int { return UserDefaultsHelper.shared.level }
  
  @IBOutlet weak var tableView: UITableView!
  
  @IBAction func backToMenu(_ sender: Any) {
    navigationController?.popToRootViewController(animated: true)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    tableView.reloadData()
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.contentInset = .init(top: 88, left: 0, bottom: 64, right: 0)
    tableView.separatorStyle = .none
  }
  
  override func viewWillAppear(_ animated: Bool) {
    guard let selectedRows = tableView.indexPathsForSelectedRows else { return }
    for indexPath in selectedRows { tableView.deselectRow(at: indexPath, animated: animated) }
    tableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! LevelsCell
    cell.configer(index: indexPath, level: bestLevel)
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfLevels
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard bestLevel >= indexPath.row else {
      tableView.deselectRow(at: indexPath, animated: true)
      return
    }
    
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "game") as? GameViewController else { return }
    vc.level = Level(level: Level.Levels.init(rawValue: indexPath.row) ?? .one)
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

