import SpriteKit
class PlayerCamera: SKNode {
        
    var dir = CGVector(dx: 1, dy: 0)
    var pos = CGVector(dx: 0, dy: 0)
    
    let initialPlane = CGVector(dx: 0, dy: -Int(tan(45 * 180 / Float.pi)))
    
    var plane: CGVector!
    let multiplyFactor: Float = 100
    var map: Map!

    let numOfRays: Int = 500
    var rays: [Ray] = []
    var rayNodes: [SKShapeNode] = []

    
    let circle = SKShapeNode(circleOfRadius: 10)
    init(map: Map) {
        super.init()
        plane = .init(dx: initialPlane.dx, dy: initialPlane.dy)
        let posX = map.cellSize * 1.5
        let posY = map.cellSize * 1.5
        pos = .init(dx: posX, dy: posY)
        position = pos.toCGPoint()
        updateDir(newDir: dir)
        self.map = map
//        addChild(circle)
    }
    
    func initialize() {
        createRays()
        createRayNodes()
        renderScene()
        
//        for _ in rays {
//
//            let node = SKShapeNode()
//            node.strokeColor = .blue
//            node.lineWidth = 8
//            node.zPosition = 100
//            rayNodes.append(node)
//            scene?.addChild(node)
//        }
    }
    
    private func map(minRange:Float, maxRange:Float, minDomain:Float, maxDomain:Float, value:Float) -> Float {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
    
    private func renderScene() {
        
        for (index, ray) in rays.enumerated() {
            
            let distance = map.findNextStripe(ray: ray)
        
            if let view = scene?.view {
                let w = view.bounds.size.width
                let h = view.bounds.size.height

                let distance = map.findNextStripe(ray: ray)
                let lineHeight = map(minRange: 0, maxRange: 1000, minDomain: Float(w), maxDomain: 0, value: distance)
                
                let path = CGMutablePath()
                
                let a = h / 2
                let b = lineHeight / 2
                let lineWidth = rayNodes[index].lineWidth
                let x = (rayNodes[index].lineWidth * CGFloat(index) + lineWidth / 2)
                path.move(to: .init(x: x, y: a - CGFloat(b)))
                path.addLine(to: .init(x: x, y: a + CGFloat(b)))
                
                rayNodes[index].path = path
            }
        
        }

        
    }
    
    func update() {
        createRays()
        renderScene()
        
//        for (index, ray) in rays.enumerated() {
//            let path = CGMutablePath()
//            
//            let distance = map.findNextStripe(ray: ray)
//            
//            path.move(to: position)
//            path.addLine(to: (position.toCGVector() + ray.dir * distance).toCGPoint())
//
//            
//            rayNodes[index].path = path
//        }
    
    }
    
    private func createRayNodes() {
        for ray in rays {
            let node = SKShapeNode()
            node.fillColor = .white
            node.lineWidth = scene!.view!.bounds.size.width / CGFloat(numOfRays)
            node.zPosition = 1000
            
            rayNodes.append(node)
            scene?.addChild(node)
        }
    }
    
    private func createRays() {
        rays = []
        
        for index in 0...numOfRays {
            
            let camera = 2 * Float(index) / Float(numOfRays) - 1; //x-coordinate in camera space
                
            let rayDir = (dir + plane * Float(camera)).normalized();

            let ray = Ray(pos: position.toCGVector(), dir: rayDir)
            rays.append(ray)
        }
    }
    
    func updateDir(newDir: CGVector) {
        dir = (newDir - position.toCGVector()).normalized()
        plane = initialPlane.rotatedBy(angleInDegrees: CGFloat(CGVector.angle(vector1: dir, vector2: .init(dx: 1, dy: 0))))
    }
    
    func moveToDir(dir: CGVector) {
        updateDir(newDir: dir)
        
        position = (position.toCGVector() + self.dir * 5).toCGPoint()

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

