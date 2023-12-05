import SpriteKit

extension SKScene {
    
    func createLine(point1: CGPoint, point2: CGPoint, color: UIColor) {
        
        let path = CGMutablePath()
        path.move(to: point1)
        path.addLine(to: point2)
        
        
        let node = SKShapeNode(path: path)
        node.strokeColor = color
        node.lineWidth = 10
        
        addChild(node)
    }
    
}
