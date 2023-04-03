import UIKit
import SpriteKit

class Stone: SKSpriteNode {
  var type: [StoneType]
  var isInvisible: Bool = false
  var stoneSize: CGFloat = 50
  var isPlaced = true
  
  enum StoneType: Int, CaseIterable {
    case purple = 0, pink, lightPink, blue, yellow, red
    
    func image(size: StoneTypeSize) -> UIImage {
      switch self {
        case .red:
          switch size {
            case .s:
              return UIImage(named: "lotus-6-s") ?? UIImage()
            case .m:
              return UIImage(named: "lotus-6-m") ?? UIImage()
            case .l:
              return UIImage(named: "lotus-6-l") ?? UIImage()
          }
        case .pink:
          switch size {
            case .s:
              return UIImage(named: "lotus-2-s") ?? UIImage()
            case .m:
              return UIImage(named: "lotus-2-m") ?? UIImage()
            case .l:
              return UIImage(named: "lotus-2-l") ?? UIImage()
          }
        case .blue:
          switch size {
            case .s:
              return UIImage(named: "lotus-5-s") ?? UIImage()
            case .m:
              return UIImage(named: "lotus-5-m") ?? UIImage()
            case .l:
              return UIImage(named: "lotus-5-l") ?? UIImage()
          }
        case .yellow:
          switch size {
            case .s:
              return UIImage(named: "lotus-1-s") ?? UIImage()
            case .m:
              return UIImage(named: "lotus-1-m") ?? UIImage()
            case .l:
              return UIImage(named: "lotus-1-l") ?? UIImage()
          }
        case .lightPink:
          switch size {
            case .s:
              return UIImage(named: "lotus-3-s") ?? UIImage()
            case .m:
              return UIImage(named: "lotus-3-m") ?? UIImage()
            case .l:
              return UIImage(named: "lotus-3-l") ?? UIImage()
          }
        default:
          switch size {
            case .s:
              return UIImage(named: "lotus-4-s") ?? UIImage()
            case .m:
              return UIImage(named: "lotus-4-m") ?? UIImage()
            case .l:
              return UIImage(named: "lotus-4-l") ?? UIImage()
          }
      }
    }
    
    var color: UIColor {
      return UIColor(named: "color\(self.rawValue + 1)") ?? .clear
    }
  }
  
  init(category: [StoneType], width: CGFloat, isBg: Bool = false, isPlaced: Bool = true) {
    self.stoneSize = width
    self.isPlaced = isPlaced
    self.type = category
    let texture = SKTexture(image: isBg ? UIImage(named: "") ?? UIImage() : category[0].image(size: .l) )
    super.init(texture: texture, color: UIColor.clear, size: texture.size())
    self.setScale(toWidth: stoneSize)
    self.name = UUID().uuidString
    var current = category[0]
    guard !isBg else { return }
    for i in StoneTypeSize.allCases {
      switch i {
        case .l:
          break
        case .m:
          if category.count > 1 {
            current = category[1]
          }
          let texture = SKTexture(image: current.image(size: i))
          let node = SKSpriteNode(texture: texture, size: CGSize(width:  texture.size().width, height:  texture.size().height))
          node.position = CGPointMake(self.frame.midX, self.frame.midY )
          self.addChild(node)
        case .s:
          if category.count > 2 {
            current = category[2]
          }
          let texture = SKTexture(image: current.image(size: i))
          let node = SKSpriteNode(texture: texture, size: CGSize(width:  texture.size().width, height:  texture.size().height))
          node.position = CGPointMake(self.frame.midX, self.frame.midY )
          self.addChild(node)
      }
    }
    
  }
  
  func changeSize(width: CGFloat) {
    self.stoneSize = width
    self.setScale(toWidth: stoneSize)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  enum StoneTypeSize: Int, CaseIterable {
    case l = 0, m, s
  }
}
