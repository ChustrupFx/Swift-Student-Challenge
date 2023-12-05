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
                
                let rayOutData = map.findNextStripe(ray: ray, camera: camera)
                let alpha = calculateAlpha(rayData: rayOutData)
                let distance = rayOutData.perpwallDistance
                let lineHeight = (h / CGFloat(distance)) * 100
                
                let path = CGMutablePath()
                
                let rayNode = camera.rayNodes[index]
                
                let a = h / 2
                let b = lineHeight / 2
                let lineWidth = rayNode.lineWidth
                let x = (rayNode.lineWidth * CGFloat(index) + lineWidth / 2)
                path.move(to: .init(x: x, y: a - CGFloat(b)))
                path.addLine(to: .init(x: x, y: a + CGFloat(b)))
                
                rayNode.path = path
                
                // Shading
                rayNode.alpha = CGFloat(alpha)
            }
            
        }
    }
    
    private func calculateAlpha(rayData: RayOutData) -> Float {
        
        var angleFromWall = CGVector.angle(vector1: camera.position.toCGVector() - rayData.pos, vector2:  rayData.normal, vectorUp: nil)
        let angleToDegrees =  Utils.toDegress(angleInRadians: angleFromWall)
        let dot = CGVector.dot(vector1: (rayData.pos * rayData.normal).normalized(), vector2: camera.position.toCGVector() - rayData.pos)
        
        if (angleFromWall > Float.pi / 2) {
            angleFromWall = Float.pi / 2
        }
        
        var alpha = 1 - (angleFromWall / (Float.pi / 2))
        
        if (alpha > 1) {
            alpha = 1
        }
        
        if (alpha < 0) {
            alpha = 0
        }
        
        return alpha
        
    }
    
}
