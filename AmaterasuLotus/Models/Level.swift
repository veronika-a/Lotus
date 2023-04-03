import Foundation
import GameKit

class Level {
  var level: Levels = .one
  var stones: [Stone] = [Stone]()
  var smallStones: [Stone] = [Stone]()
  
  init(level: Levels) {
    self.level = level
  }
  
  func setupStones(stoneSize: CGFloat, smallStoneSize: CGFloat) {
    stones.removeAll()
    smallStones.removeAll()

    for s in 0..<level.stones.count {
      let stone = Stone(category: level.stones[s], width: stoneSize - 8)
      stone.name = "\(s)"
      stones.append(stone)
    }
    for s in 0..<level.smallStones.count {
      let stone = Stone(category: level.smallStones[s], width: smallStoneSize - 8, isPlaced: false)
      stone.name = "\(s)"
      smallStones.append(stone)
    }
  }
  
  enum Levels: Int, CaseIterable {
    case one = 0, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen, twenty
    
    var treasure: String? {
      switch self {
        case .three:
          return "item1"
        case .six:
          return "item2"
        case .ten:
          return "item3"
        case .fourteen:
          return "item4"
        case .seventeen:
          return "item5"
        case .twenty:
          return "item6"
        default:
          return nil
      }
    }
    
    var stones: [[Stone.StoneType]] {
      switch self {
        case .one:
          return [[.blue]]
        case .two:
          return [[.pink], [.yellow], [.lightPink], [.pink]]
        case .three:
          return [[.yellow], [.blue], [.red], [.pink], [.yellow], [.blue]]
        case .four:
          return [[.lightPink], [.blue], [.yellow, .lightPink], [.red], [.yellow, .red, .blue], [.pink, .yellow]]
        case .five:
          return [[.lightPink], [.pink, .blue, .lightPink], [.blue], [.pink], [.yellow], [.lightPink, .red]]
        case .six:
          return [[.yellow], [.red, .blue, .lightPink], [.blue, .pink], [.pink, .red], [.pink], [.yellow, .red]]
        case .seven:
          return [[.yellow], [.lightPink], [.red, .pink, .lightPink], [.blue]]
        case .eight:
          return [[.lightPink], [.pink], [.yellow], [.lightPink, .blue], [.blue, .red], [.lightPink], [.blue]]
        case .nine:
          return [[.blue, .lightPink], [.pink, .yellow], [.blue, .lightPink], [.red]]
        case .ten:
          return [[.blue, .pink], [.yellow, .pink, .lightPink], [.red, .pink, .blue], [.yellow]]
        case .eleven:
          return [[.lightPink], [.pink, .lightPink], [.blue], [.yellow, .pink, .blue], [.pink], [.blue, .lightPink, .red], [.lightPink], [.red, .lightPink, .pink], [.red]]
        case .twelve:
          return [[.lightPink], [.red, .blue, .lightPink], [.yellow, .red, .pink], [.lightPink, .blue, .red], [.pink, .lightPink], [.red, .pink, .lightPink], [.pink]]
        case .thirteen:
          return [[.pink], [.lightPink], [.blue, .red, .pink], [.blue], [.yellow], [.yellow, .pink, .red], [.lightPink], [.red]]
        case .fourteen:
          return [[.lightPink], [.blue], [.lightPink], [.red, .pink, .blue], [.blue, .pink], [.yellow], [.yellow], [.lightPink], [.red]]
        case .fifteen:
          return [[.lightPink], [.blue, .lightPink], [.yellow, .pink], [.red, .blue], [.blue, .lightPink], [.lightPink]]
        case .sixteen:
          return [[.yellow, .red], [.lightPink], [.pink, .blue], [.red, .blue, .lightPink]]
        case .seventeen:
          return [[.lightPink], [.pink], [.blue, .yellow], [.red], [.lightPink, .yellow], [.blue]]
        case .eighteen:
          return [[.pink, .blue, .lightPink], [.lightPink], [.red, .yellow], [.red], [.pink, .red, .lightPink]]
        case .nineteen:
          return [[.pink, .blue, .lightPink], [.red, .pink], [.yellow, .red]]
        case .twenty:
          return [[.lightPink], [.pink, .lightPink], [.blue], [.yellow], [.red], [.pink, .blue], [.lightPink, .blue, .red]]
      }
    }
    
    var smallStones: [[Stone.StoneType]] {
      switch self {
        case .one:
          return [[.blue]]
        case .two:
          return [[.pink, .lightPink, .yellow]]
        case .three:
          return [[.yellow], [.red], [.pink, .blue]]
        case .four:
          return [[.lightPink], [.blue], [.yellow], [.pink]]
        case .five:
          return [[.yellow, .red, .pink], [.lightPink], [.pink]]
        case .six:
          return [[.yellow, .pink], [.lightPink], [.yellow], [.red, .blue], [.blue]]
        case .seven:
          return [[.red], [.blue, .lightPink], [.pink], [.yellow, .red]]
        case .eight:
          return [[.blue, .lightPink], [.red], [.lightPink], [.yellow], [.blue], [.pink]]
        case .nine:
          return [[.yellow, .blue, .lightPink], [.yellow], [.red], [.pink]]
        case .ten:
          return [[.blue], [.red], [.blue, .lightPink], [.yellow, .pink], [.yellow, .pink]]
        case .eleven:
          return [[.lightPink], [.blue], [.pink, .yellow], [.red], [.yellow, .red, .blue]]
        case .twelve:
          return [[.lightPink, .pink], [.red], [.yellow, .blue], [.pink], [.blue], [.blue], [.red]]
        case .thirteen:
          return [[.red, .lightPink], [.pink], [.yellow], [.pink], [.lightPink], [.blue, .red], [.blue, .yellow]]
        case .fourteen:
          return [[.yellow, .red], [.yellow], [.lightPink], [.blue], [.blue, .lightPink], [.red, .pink], [.pink, .blue]]
        case .fifteen:
          return [[.pink, .blue], [.yellow], [.red]]
        case .sixteen:
          return [[.pink], [.pink], [.pink, .lightPink], [.lightPink], [.blue, .lightPink], [.yellow, .red]]
        case .seventeen:
          return [[.blue], [.pink, .blue], [.pink, .lightPink], [.yellow, .pink], [.red], [.lightPink]]
        case .eighteen:
          return [[.yellow, .blue], [.red], [.pink], [.pink, .lightPink]]
        case .nineteen:
          return [[.yellow, .blue], [.blue], [.pink], [.pink], [.blue, .lightPink]]
        case .twenty:
          return [[.red, .pink], [.lightPink, .red], [.blue, .lightPink], [.yellow], [.pink]]
      }
    }
    
    var places: [[Int]] {
      switch self {
        case .one:
          return [[2, 1]]
        case .two:
          return [[1, 1], [2, 0], [2, 2], [3, 1]]
        case .three:
          return [[1, 0], [1, 3], [2, 1], [2, 2], [3, 0], [3, 3]]
        case .four:
          return [[1, 0], [1, 2], [2, 0], [2, 1], [2, 2], [2, 3]]
        case .five:
          return [[2, 0], [2, 1], [2, 2], [2, 3], [3, 0], [3, 2]]
        case .six:
          return [[1, 0], [2, 1], [2, 2], [2, 3], [3, 0], [3, 3]]
        case .seven:
          return [[1, 1], [1, 2], [2, 1], [3, 2]]
        case .eight:
          return [[1, 1], [2, 0], [2, 1], [2, 2], [3, 1], [3, 3], [4, 0]]
        case .nine:
          return [[1, 1], [2, 0], [3, 1], [3, 2]]
        case .ten:
          return [[1, 0], [1, 2], [2, 1], [3, 2]]
        case .eleven:
          return [[0, 0], [1, 0], [1, 1], [2, 0], [2, 1], [2, 2], [3, 1], [3, 2], [4, 3]]
        case .twelve:
          return [[1, 0], [2, 0], [2, 2], [2, 3], [3, 1], [3, 3], [4, 3]]
        case .thirteen:
          return [[0, 2], [1, 1], [1, 3], [2, 0], [2, 2], [3, 0], [3, 2], [4, 1]]
        case .fourteen:
          return [[1, 0], [1, 1], [1, 2], [2, 1], [2, 2], [3, 0], [3, 2], [3, 3], [4, 1]]
        case .fifteen:
          return [[0, 0], [1, 0], [2, 1], [3, 2], [3, 3], [4, 3]]
        case .sixteen:
          return [[1, 1], [1, 3], [2, 0], [2, 2]]
        case .seventeen:
          return [[2, 1], [2, 2], [3, 1], [4, 1], [4, 2], [4, 3]]
        case .eighteen:
          return [[1, 1], [2, 1], [2, 2], [3, 0], [3, 1]]
        case .nineteen:
          return [[1, 1], [2, 2], [3, 2]]
        case .twenty:
          return [[0, 0], [1, 1], [2, 0], [2, 3], [3, 3], [4, 2], [4, 3]]
      }
    }
  }
}
