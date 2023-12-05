import SpriteKit

class Scene1: SKScene {
    
    var player: PlayerCamera!asd
    let map = Map()
    let circle: SKShapeNode = {
        let circle = SKShapeNode(circleOfRadius: 20)
        circle.fillColor = .cyan
        asdasdasd        return circle
    }()
    var mapNodes: [SKShapeNode] = []
        
    override func didMove(to view: SKView) {
        player = .init(map: map)
//        map.renderInScene(scene: self)
        view.showsNodeCount = true
//        addChild(circle)
        addChild(player)
        
        
        player.initialize()
    
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
//        let asd = map.findNextStripe(ray: player)
        
//        circle.position = asd
        player.update()
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let first = touches.first
        
        let location = first?.location(in: self)
        
        let vector = location?.toCGVector()
   
        player.moveToDir(dir: vector!)
        
    }

}


