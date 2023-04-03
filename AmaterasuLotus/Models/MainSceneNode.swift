import SpriteKit

enum Side: CaseIterable {
  case left, right, bot, top
}

class MenuSceneNode: SKSpriteNode {
  
  private var currentSide: Side!
  
  init(number: Int) {
    let texture = SKTexture(imageNamed: "petal-\(number)")
    super.init(texture: texture, color: .clear, size: texture.size())
    self.setScale(toWidth: 20)
    zPosition = 10
    name = "menuNode"
    spawn()
  }
  
  func animate() {
    var sides = Side.allCases
    sides.removeAll(where: { $0 == currentSide })
    let moveTo = randomPosition(from: sides)
    
    let randomAngle = CGFloat.random(in: -(.pi * 3)...(.pi * 3))
    run(.rotate(toAngle: randomAngle, duration: Double.random(in: 8...14), shortestUnitArc: false))
    run(.move(to: moveTo, duration: Double.random(in: 4...14))) {
      self.spawn()
      self.animate()
    }
  }
  
  func spawn() {
    self.position = randomPosition(from: Side.allCases)
  }
  
  private func randomPosition(from sides: [Side]) -> CGPoint {
    let bounds = UIScreen.main.bounds
    
    let yScope = -(bounds.height / 2 + 40)...(bounds.height / 2 + 40)
    let xScope = -(bounds.width / 2 + 40)...(bounds.width / 2 + 40)
    
    guard let side = sides.randomElement() else { return .zero }
    var position = CGPoint()
    
    switch side {
      case .left:
        position = CGPoint(x: xScope.lowerBound,
                           y: CGFloat.random(in: yScope))
      case .right:
        position = CGPoint(x: xScope.upperBound,
                           y: CGFloat.random(in: yScope))
      case .bot:
        position = CGPoint(x: CGFloat.random(in: xScope),
                           y: yScope.lowerBound)
      case .top:
        position = CGPoint(x: CGFloat.random(in: xScope),
                           y: yScope.upperBound)
    }
    
    if sides == Side.allCases {
      currentSide = side
    }
    
    return position
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

