import SpriteKit

class MenuScene: SKScene {
    
    // MARK: - Lifecycle
    override func didMove(to view: SKView) {
        self.backgroundColor = .clear
        createNodes()
    }
    
    private func createNodes() {
        for i in 0...7 {
            let node = MenuSceneNode(number: i)
            addChild(node)
            node.animate()
        }
    }
    
    func hideNodes(_ completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            self.children.forEach { node in
                node.run(.fadeOut(withDuration: 0.5)) {
                    node.removeAllActions()
                }
            }
            self.run(.wait(forDuration: 0.5)) {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func hideNodes() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.children.forEach { node in
                node.run(.fadeOut(withDuration: 0.5)) {
                    node.removeAllActions()
                }
            }
        }
    }
    
    func showNodes() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.children.forEach { node in
                guard let node = node as? MenuSceneNode else { return }
                node.alpha = 1
                node.spawn()
                node.animate()
            }
        }
    }
}


