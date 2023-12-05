import SpriteKit

class Ray {
    
    let dir: CGVector
    let maxDistance: Float
    let pos: CGVector
    
    init(pos: CGVector, dir: CGVector, maxDistance: Float = 10000) {
        self.dir = dir
        self.maxDistance = maxDistance
        self.pos = pos
    }
    
}
