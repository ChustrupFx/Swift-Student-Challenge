struct Utils {
    
    static func map(minRange:Float, maxRange:Float, minDomain:Float, maxDomain:Float, value:Float) -> Float {
        return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
    }
    
    static func toDegress(angleInRadians: Float) -> Float {
        
        return angleInRadians * 180 / Float.pi
        
    }
    
    static func toRadians(angleInDegrees: Float) -> Float {
        
        return angleInDegrees * Float.pi / 180
        
    }
}
