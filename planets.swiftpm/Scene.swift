import SpriteKit

class Scene1: SKScene {
    
    var player: PlayerCamera!
    let map = Map()
    let circle: SKShapeNode = {
        let circle = SKShapeNode(circleOfRadius: 20)
        circle.fillColor = .cyan
            return circle
    }()
    var mapNodes: [SKShapeNode] = []
    var sceneRenderer: SceneRenderer!
        
    override func didMove(to view: SKView) {
        player = .init(map: map)
//        map.renderInScene(scene: self)
        view.showsNodeCount = true
//        addChild(circle)
        addChild(player)
        
        
        player.initialize()
    
        sceneRenderer = .init(camera: player, map: map)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
//        let asd = map.findNextStripe(ray: player)
        
//        circle.position = asd
        player.update()
        
        sceneRenderer.renderIn(scene: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let first = touches.first
        
        let location = first?.location(in: self)
        
        let vector = location?.toCGVector()
   
        player.moveToDir(dir: vector!)
        
    }

}


