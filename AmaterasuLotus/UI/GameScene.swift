
import SpriteKit

protocol GameProtocol: AnyObject {
  func gameOver(win: Bool)
}

class GameScene: SKScene {
  
  var vc: GameViewController?
  private var item: Stone?
  private var treasure: SKSpriteNode?
  private var itemStartPosition: CGPoint = .zero
  private var spikes: SKSpriteNode?
  var isGameOver: Bool = false
  private var scoreLabel: SKLabelNode!
  
  private var stoneSize: CGFloat = 0
  private var smalStoneSize: CGFloat = 0
  weak var gameProtocol: GameProtocol?
  private var background = SKSpriteNode(imageNamed: "bg2")
  
  private var matrix: [[Stone?]] = []
  private var matrixPosition: [[CGPoint]] = []
  private var smallMatrix: [[Stone?]] = []
  var level: Level = Level(level: .one)
  var isUpdateMatrix = false
  var timer: Timer?
  var time = 0

  func setUpScene() {
    stoneSize = ((self.frame.size.width - 80) / 4)
    smalStoneSize = ((self.frame.size.width - 80 - 10) / 5)
    level.setupStones(stoneSize: stoneSize, smallStoneSize: smalStoneSize)
    createMatrix()
    if level.level.treasure != nil {
      setupTimer()
    }
  }
  
  private func setupTimer() {
    let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    self.timer = timer
  }

  @objc private func fireTimer() {
    time = time + 1
    if time == 10 {
      timer?.invalidate()
      timer = nil
      guard let img = level.level.treasure else { return }
      let texture = SKTexture(imageNamed: img)
      let item = SKSpriteNode(texture: texture, color: .clear, size: texture.size())
      item.setScale(toWidth: 70)
      zPosition = 10
      name = img
      
      let xScope = 0...UIScreen.main.bounds.width
      item.position = CGPoint(x: CGFloat.random(in: xScope), y: 0)
      self.addChild(item)
      treasure = item
      var sides = Side.allCases
      sides.removeAll(where: { $0 == .bot })
      let x = (0 - 35)...(UIScreen.main.bounds.width + 35)
      let moveTo = CGPoint(x: CGFloat.random(in: x), y: UIScreen.main.bounds.height + 35)
      let randomAngle = CGFloat.random(in: -(.pi * 3)...(.pi * 3))
      item.run(.rotate(toAngle: randomAngle, duration: Double.random(in: 8...14), shortestUnitArc: false))
      item.run(.move(to: moveTo, duration: Double.random(in: 4...14))) {
        item.removeFromParent()
      }
    }
  }
  
  private func createMatrix() {
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    let topPadding = (window?.safeAreaInsets.top ?? 0) + (view?.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    
    let minX = stoneSize / 2 + 40
    let minY: CGFloat = self.frame.height - topPadding - 110 - stoneSize / 2

    var x = minX
    var y = minY
    matrix = Array(repeating: Array(repeating: nil, count: 4), count: 5)
    matrixPosition = Array(repeating: Array(repeating: .zero, count: 4), count: 5)
    smallMatrix = Array(repeating: Array(repeating: nil, count: 5), count: 2)

    for i in 0..<matrix.count {
      for j in 0..<matrix[i].count {
        let position = CGPoint(x: x, y: y)
        matrixPosition[i][j] = position
        x = x + stoneSize
      }
     
      y = y - stoneSize
      x = minX
    }
    
    print(matrixPosition)
    print(matrix)
    
    for i in 0..<matrix.count {
      for j in 0..<matrix[i].count {
        if !(matrix[i][j]?.isInvisible ?? false) {
          let stoneBg = Stone(category: [.purple], width: stoneSize - CGFloat(4 * (4 - 1)), isBg: true)
          stoneBg.position = matrixPosition[i][j]
          self.addChild(stoneBg)
//
//          let rightSize = CGSize(width: stoneSize, height: stoneSize)
//          let right = SKShapeNode(rectOf: rightSize)
//          right.strokeColor = .yellow
//          right.position = matrixPosition[i][j]
//          addChild(right)
        }
      }
    }
    
    for s in 0..<level.stones.count {
      guard let i = level.level.places[s].first, let j = level.level.places[s].last else { return }

      level.stones[s].position = matrixPosition[i][j]
      matrix[i][j] = level.stones[s]
      self.addChild(matrix[i][j]!)
    }
    
    
    guard let lastY = matrixPosition.last?.last?.y else { return }
    
    let background = SKSpriteNode(imageNamed: "rect")
    background.setScale(toWidth: frame.size.width)
    background.size = CGSize(width: self.size.width, height: background.size.height)
    background.position = CGPoint(x: frame.size.width / 2, y: lastY - 1.5 * smalStoneSize + 16 - background.size.height / 2)
    self.addChild(background)
    
    var sx = minX
    var sy = lastY - 2 * smalStoneSize
    var small = 0
    for i in 0..<smallMatrix.count {
      for j in 0..<smallMatrix[i].count {
        let position = CGPoint(x: sx, y: sy)
        if level.smallStones.count > small {
          smallMatrix[i][j] = level.smallStones[small]
          smallMatrix[i][j]?.position = position
          self.addChild(smallMatrix[i][j]!)
        }
        small = small + 1
        sx = sx + smalStoneSize
      }
      sy = sy - smalStoneSize
      sx = minX
    }
    
  }
  
  private func updateMatrix(at pos: CGPoint? = nil, node: Stone) {
    guard let position = pos != nil ? pos : node.position else { return }
    let maxY = (matrixPosition.first?.first?.y ?? 0) + stoneSize / 2
    let minY = (matrixPosition.last?.last?.y ?? 0) - stoneSize / 2
    guard position.y > minY, position.y < maxY else {
      let move = SKAction.move(to: itemStartPosition, duration: 0.3)
      node.run(move)
      return
    }
    var foundY: Int? = nil
    for i in 0..<matrixPosition.count {
      if (matrixPosition[i].first?.y ?? 0) + stoneSize / 2 > position.y, (matrixPosition[i].first?.y ?? 0) - stoneSize / 2 < position.y {
        foundY = i
        break
      }
    }
    guard let foundY = foundY else {
      let move = SKAction.move(to: itemStartPosition, duration: 0.3)
      node.run(move)
      return }
    let minX = (matrixPosition[foundY].first?.x ?? 0) - stoneSize / 2
    let maxX = (matrixPosition[foundY].last?.x ?? 0) + stoneSize / 2
    guard position.x > minX, position.x < maxX else {
      let move = SKAction.move(to: itemStartPosition, duration: 0.3)
      node.run(move)
      return
    }
    
    var foundX: Int? = nil
    for i in 0..<matrixPosition[foundY].count {
      if matrixPosition[foundY][i].x + stoneSize / 2 > position.x, matrixPosition[foundY][i].x - stoneSize / 2 < position.x {
        foundX = i
        break
      }
    }
    guard let foundX = foundX else {
      let move = SKAction.move(to: itemStartPosition, duration: 0.3)
      node.run(move)
      return
    }
    
    if matrix[foundY][foundX] == nil {
      node.isPlaced = true
      node.removeFromParent()
      node.changeSize(width: stoneSize - 8)
      addChild(node)
      for i in 0..<smallMatrix.count {
        for j in 0..<smallMatrix[i].count {
          if smallMatrix[i][j] == node {
            smallMatrix[i][j] = nil
          }
        }
      }
      self.matrix[foundY][foundX] = node
      let move = SKAction.move(to: matrixPosition[foundY][foundX], duration: 0.5)
      node.run(move, completion: { [weak self] in
        guard let self = self else { return }
        let mass = self.inspectContact(i: foundY, j: foundX, array: [[foundY, foundX]])
        self.updateToNew(mass: mass, i: foundY, j: foundX)
      })
    } else {
      let move = SKAction.move(to: itemStartPosition, duration: 0.3)
      node.run(move)
    }
  }
  
  private func isMatrixEmpty(isSmall: Bool = false) {
    var flag = true
    switch !isSmall {
      case true:
        for i in matrix {
          for j in i {
            if j != nil {
              flag = false
            }
          }
        }
        if flag {
          gameOver(win: true)
        }
      case false:
        for i in smallMatrix {
          for j in i {
            if j != nil {
              flag = false
            }
          }
        }
        if flag {
          gameOver(win: false)
        }
    }
  }
  
  private func inspectContact(i: Int, j: Int, array: [[Int]] = [[Int]]()) -> [[Int]] {
    var mass: [[Int]] = array
    if i > 0, let node = matrix[i - 1][j], node.type.first == matrix[i][j]?.type.first, !mass.contains([i - 1, j]){
      mass.append([i - 1, j])
    }
    if i < matrix.count - 1, let node = matrix[i + 1][j], node.type.first == matrix[i][j]?.type.first, !mass.contains([i + 1, j]) {
      mass.append([i + 1, j])
    }
    
    if j > 0, let node = matrix[i][j - 1], node.type.first == matrix[i][j]?.type.first, !mass.contains([i, j - 1]) {
      mass.append([i,j - 1])
    }
    if j < matrix[i].count - 1, let node = matrix[i][j + 1], node.type.first == matrix[i][j]?.type.first,
        !mass.contains([i, j + 1]) {
      mass.append([i,j + 1])
    }
    
    if !mass.isEmpty {
      var s = 0
      var count = mass.count
      while s < count {
        if let first = mass[s].first, let last = mass[s].last, !array.contains(mass[s]) {
          let m = inspectContact(i: first, j: last, array: mass)
          m.forEach({ if !mass.contains($0) {
            mass.append($0)
            count = count + 1
          }
          })
        }
        s = s + 1
      }
    }
    return mass
  }
  
  func updateToNew(mass: [[Int]], i: Int, j: Int) {
    guard !mass.isEmpty, mass.count > 1 else {
      isMatrixEmpty(isSmall: true)
      return
    }
    mass.forEach({
      guard let first = $0.first, let last = $0.last else { return }
      if first == i, last == j { return }
      var type = matrix[first][last]?.type
      type?.removeFirst()
      if let type = type, type.count > 0 {
        let new = Stone(category: type, width: stoneSize - 8)
        new.position = matrixPosition[first][last]
        let rotate = SKAction.rotate(byAngle: 2*CGFloat.pi, duration: 0.5)
        matrix[first][last]?.run(rotate) { [weak self] in
          guard let self = self else { return }
          self.matrix[first][last]?.removeFromParent()
          self.addChild(new)
          self.matrix[first][last] = nil
          self.updateMatrix(node: new)
        }
      } else {
        let rotate = SKAction.rotate(byAngle: 2*CGFloat.pi, duration: 0.5)
        let removed = self.matrix[first][last]
        self.matrix[first][last] = nil
        removed?.run(rotate) {
          removed?.removeFromParent()
        }
      }
    })
    guard var mType = matrix[i][j]?.type else { return }
    mType.removeFirst()
    
    let rotate = SKAction.rotate(byAngle: 2*CGFloat.pi, duration: 0.5)
    matrix[i][j]?.run(rotate) { [weak self] in
      guard let self = self else { return }
      self.matrix[i][j]?.removeFromParent()
      self.matrix[i][j] = nil
      if mType.count > 0 {
        let new = Stone(category: mType, width: self.stoneSize - 8)
        new.position = self.matrixPosition[i][j]
        self.addChild(new)
        self.updateMatrix(node: new)
      } else {
        self.isMatrixEmpty()
      }
    }
  }
  
  override func didMove(to view: SKView) {
    background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    background.size = CGSize(width: self.size.width, height: self.size.height)
    self.addChild(background)
    self.setUpScene()
  }
  
  private func makeMove(at pos: CGPoint) {
    guard item != nil else { return }
    updateMatrix(at: pos, node: item!)
  }
  
  private func gameOver(win: Bool) {
    guard !isGameOver else { return }
    isGameOver = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.removeAllActions()
      self.removeAllChildren()
      self.vc?.gameOver(win: win)
    }
  }
  
}

extension GameScene {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      if treasure != nil, treasure!.contains(t.location(in: self)) {
        self.treasure?.removeFromParent()
        switch level.level {
          case .three:
            UserDefaultsHelper.shared.element1 = true
          case .six:
            UserDefaultsHelper.shared.element2 = true
          case .ten:
            UserDefaultsHelper.shared.element3 = true
          case .fourteen:
            UserDefaultsHelper.shared.element4 = true
          case .seventeen:
            UserDefaultsHelper.shared.element5 = true
          case .twenty:
            UserDefaultsHelper.shared.element6 = true
          default:
            break
        }
        
      }
      let location = t.location(in: self)
      for i in level.smallStones {
        if i.contains(location), !i.isPlaced {
          self.itemStartPosition = i.position
          self.item = i
        }
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    for t in touches {
      let location = t.location(in: self)
      let move = SKAction.move(to: location, duration: 0.3)
      item?.run(move)
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
    for t in touches {
      let location = t.location(in: self)
      makeMove(at: location)
    }
    item = nil
    //check()
  }
}
