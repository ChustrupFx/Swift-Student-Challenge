import SpriteKit

extension CGPoint {
    
    func toCGVector() -> CGVector {
        return .init(dx: x, dy: y)
    }
    
}
