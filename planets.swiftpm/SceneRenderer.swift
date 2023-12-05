import SpriteKit

class SceneRenderer {
    
    let camera: PlayerCamera
    let map: Map
    
    init(camera: PlayerCamera, map: Map) {
        
        self.camera = camera
        self.map = map
        
    }
    
    public func renderIn(scene: SKScene) {
        
        let rays = camera.rays
        
        
        for (index, ray) in rays.enumerated() {
            
            if let view = scene.view {
                let w = view.bounds.size.width
                let h = view.bounds.size.height
                
                let distance = map.findNextStripe(ray: ray, camera: camera)
                let lineHeight = Utils.map(minRange: 0, maxRange: 1000, minDomain: Float(w), maxDomain: 0, value: distance)
                
                let path = CGMutablePath()
                
                let rayNode = camera.rayNodes[index]
                
                let a = h / 2
                let b = lineHeight / 2
                let lineWidth = rayNode.lineWidth
                let x = (rayNode.lineWidth * CGFloat(index) + lineWidth / 2)
                path.move(to: .init(x: x, y: a - CGFloat(b)))
                path.addLine(to: .init(x: x, y: a + CGFloat(b)))
                
                rayNode.path = path
            }
            
        }
        
        
    }
    
}
