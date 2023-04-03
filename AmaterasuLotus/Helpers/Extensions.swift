import UIKit
import GameKit

// Screen width.
public var screenWidth: CGFloat {
  return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
  return UIScreen.main.bounds.height
}

extension SKSpriteNode {
  func setScale(toWidth: CGFloat) {
    self.setScale(1)
    let ration = toWidth / self.frame.width
    self.setScale(ration)
  }
  
  func setScale(toHeight: CGFloat) {
    self.setScale(1)
    let ration = toHeight / self.frame.height
    self.setScale(ration)
  }
}

extension CGRect {
  func rangeByX() -> ClosedRange<CGFloat> {
    return (minX...maxX)
  }
  
  func rangeByY() -> ClosedRange<CGFloat> {
    return (minY...maxY)
  }
}

extension UIImage {
  static func gradientImage(withBounds: CGRect, startPoint: CGPoint, endPoint: CGPoint , colors: [CGColor]) -> UIImage {
    
    // Configure the gradient layer based on input
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = withBounds
    gradientLayer.colors = colors
    gradientLayer.startPoint = startPoint
    gradientLayer.endPoint = endPoint
    gradientLayer.cornerRadius = 10
    
    // Render the image using the gradient layer
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
  }
}

extension UIAlertController {
  
  //Set background color of UIAlertController
  func setBackgroundColor(color: UIColor) {
    if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }
  
  //Set title font and title color
  func setTitlet(font: UIFont?, color: UIColor?) {
    guard let title = self.title else { return }
    let attributeString = NSMutableAttributedString(string: title)//1
    if let titleFont = font {
      attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                                    range: NSMakeRange(0, title.utf8.count))
    }
    
    if let titleColor = color {
      attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                                    range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributeString, forKey: "attributedTitle")//4
  }
  
  //Set message font and message color
  func setMessage(font: UIFont?, color: UIColor?) {
    guard let message = self.message else { return }
    let attributeString = NSMutableAttributedString(string: message)
    if let messageFont = font {
      attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                    range: NSMakeRange(0, message.utf8.count))
    }
    
    if let messageColorColor = color {
      attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                    range: NSMakeRange(0, message.utf8.count))
    }
    self.setValue(attributeString, forKey: "attributedMessage")
  }
  
  //Set tint color of UIAlertController
  func setTint(color: UIColor) {
    self.view.tintColor = color
  }
}
