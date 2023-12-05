import SpriteKit

extension CGVector {
    
    func magnitude() -> CGFloat {
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }
    
    static func dot(vector1: CGVector, vector2: CGVector) -> Float {
        
        return Float(vector1.dx * vector2.dx + vector1.dy * vector2.dy)
    }
    
    static func angle(vector1: CGVector, vector2: CGVector, vectorUp: CGVector? = .init(dx: 0, dy: 1)) -> Float {
        
        
        var angle: Float = Float(acos(CGFloat(CGVector.dot(vector1: vector1, vector2: vector2)) / vector1.magnitude() * vector2.magnitude()))
        
        if let vectorUp = vectorUp {
            let dot = CGVector.dot(vector1: vector1, vector2: vectorUp)
            
            
            if (dot < 0) {
                angle *= -1
            }
        }
        
        return angle
    }
    
    func rotatedBy(angleInDegrees: CGFloat) -> CGVector {
        let x = dx * cos(angleInDegrees) - dy * sin(angleInDegrees)
        let y = dx * sin(angleInDegrees) + dy * cos(angleInDegrees)
        
        return .init(dx: x, dy: y)
    }
    
    func normalized() -> Self {
        let magnitude = magnitude()
        
        let newX = dx / magnitude
        let newY = dy / magnitude
        
        return .init(dx: newX, dy: newY)
    }
    
    
    func toCGPoint() -> CGPoint {
        return .init(x: dx, y: dy)
    }
}

extension CGVector {
    static func *(vector1: CGVector, vector2: CGVector) -> CGVector {
        
        return CGVector(dx: vector1.dx * vector2.dx, dy: vector2.dy * vector1.dy)
        
    }
    
    static func +(vector1: CGVector, vector2: CGVector) -> CGVector {
        
        return CGVector(dx: vector1.dx + vector2.dx, dy: vector1.dy + vector2.dy)
        
    }
    
    static func +(vector1: CGVector, value: Float) -> CGVector {
        
        return CGVector(dx: vector1.dx + CGFloat(value), dy: vector1.dy + CGFloat(value))
        
    }
    
    static func -(vector1: CGVector, vector2: CGVector) -> CGVector {
        
        return CGVector(dx: vector1.dx - vector2.dx, dy: vector1.dy - vector2.dy)
        
    }
    
    static func *(vector1: CGVector, value: Float) -> CGVector {
        
        return CGVector(dx: vector1.dx * CGFloat(value), dy: vector1.dy * CGFloat(value))
        
    }
    
}
