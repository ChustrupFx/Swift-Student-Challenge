import SpriteKit

struct RayOutData {
    let euclidianDistance: Float
    let perpwallDistance: Float
    let normal: CGVector
    let pos: CGVector
    let dir: CGVector
}

enum Direction: Int {
    case north, east, south, west
}

class Map {
    
    let map: [[Int]] = [
        [1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,1],
        [1,0,1,0,0,0,0,0,1],
        [1,1,0,0,0,0,0,0,1],
        [1,1,0,0,0,0,0,0,1],
        [1,1,0,0,0,0,0,0,1],
        [1,0,0,0,0,1,1,1,1],
        [1,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1]
    ]
    
    let cellSize: CGFloat = 80
    var mapSize: CGVector {
        return CGVector(dx: map[0].count, dy: map.count)
    }
    
    func findNextStripe(ray: Ray, camera: PlayerCamera) -> RayOutData {
        let dir = ray.dir
        let pos = ray.pos
        
        let delta = CGVector(dx: sqrt(1 + pow((dir.dy/dir.dx), 2)), dy: sqrt(1 + pow((dir.dx/dir.dy), 2)))
        
        var sideDist = CGVector.zero
        var step: CGVector = .zero;
        var currentMap = CGVector(dx: Int(pos.dx / cellSize), dy: Int(pos.dy / cellSize))
        var direction: Direction!
        
        if (dir.dx > 0) {
            // Quando o player está olhando para direita
            
            // Coordenada para o stripe a direita do player
            sideDist.dx = (pos.dx - pos.dx.truncatingRemainder(dividingBy: cellSize) + cellSize - pos.dx) * delta.dx
            
            step.dx = 1
            
            
        } else {
            // Quando o player está olhando para esquerda
            
            // Coordenada para o stripe a esquerda do player
            sideDist.dx = (pos.dx - (pos.dx -  pos.dx.truncatingRemainder(dividingBy: cellSize))) * delta.dx
            step.dx = -1
        }
        
        if (dir.dy > 0) {
            // Quando o player está olhando para cima
            
            // Coordenada para o stripe a cima do player
            sideDist.dy = (pos.dy - pos.dy.truncatingRemainder(dividingBy: cellSize) + cellSize - pos.dy) * delta.dy
            
            step.dy = 1
        } else {
            // Quando o player está olhando para baixo
            
            // Coordenada para o stripe a baixo do player
            sideDist.dy = (pos.dy - (pos.dy - pos.dy.truncatingRemainder(dividingBy: cellSize))) * delta.dy
            step.dy = -1
        }
        
        var hit = false
        var euclidianDistance: Float = 0
        let maxDistance: Float = 1000
        
        while (!hit && euclidianDistance < maxDistance) {
            if (sideDist.dx < sideDist.dy) {
                // Quando o stripe X está mais perto do que o stripe Y
                currentMap.dx += step.dx
                euclidianDistance = Float(sideDist.dx)
                sideDist.dx += delta.dx * cellSize
                
                direction = dir.dx < 0 ? .east : .west
                
            } else {
                // Quando o stripe Y está mais perto do que o stripe X
                euclidianDistance = Float(sideDist.dy)
                currentMap.dy += step.dy
                sideDist.dy += delta.dy * cellSize
                
                direction = dir.dy < 0 ? .north : .south
            }
            
            if (currentMap.dx >= 0 && currentMap.dx < mapSize.dx && currentMap.dy >= 0 && currentMap.dy < mapSize.dy) {
                if (map[Int(currentMap.dy)][Int(currentMap.dx)] == 1) {
                    hit = true
                }
            }
            
        }
        
        euclidianDistance = min(maxDistance, euclidianDistance)
        let angleToCamDir = CGVector.angle(vector1: dir, vector2: camera.dir)
        
        let perWallDist = (euclidianDistance - 1) * cos(angleToCamDir)
        
        return .init(euclidianDistance: euclidianDistance, perpwallDistance: perWallDist, normal: calcNormalOfDirection(direction: direction), pos: camera.position.toCGVector() + dir * euclidianDistance, dir: dir)
    }
    
    private func calcNormalOfDirection(direction: Direction) -> CGVector {
        
        switch(direction) {
                
            case .north:
                return .init(dx: 0, dy: 1)
            case .east:
                return .init(dx: 1, dy: 0)
            case .south:
                return .init(dx: 0, dy: -1)
            case .west:
                return .init(dx: -1, dy: 0)
        }
        
    }
    
    
    func renderInScene(scene: SKScene) -> [SKShapeNode] {
        var nodes: [SKShapeNode] = []
        
        
        for x in 0..<Int(mapSize.dx) {
            
            for y in 0..<Int(mapSize.dy) {
                
                let dx = CGFloat(x) * cellSize
                let dy = CGFloat(y) * cellSize
                
                let pos: CGVector = .init(dx: dx, dy: dy)
                
                let node = SKShapeNode(rect: .init(x: CGFloat(pos.dx), y: CGFloat(pos.dy), width: cellSize, height: cellSize))
                node.strokeColor = .init(red: 0, green: 0, blue: 0, alpha: 0)
//                node.fillColor = map[y][x] == 0 ? .black : .red
                
                if (map[y][x] != 0) {
                    
                    node.physicsBody = SKPhysicsBody(edgeLoopFrom: .init(origin: pos.toCGPoint(), size: .init(width: cellSize, height: cellSize)))
                    node.physicsBody?.affectedByGravity = false
                    node.physicsBody?.isDynamic = false
                    
                }
                
                scene.addChild(node)
                nodes.append(node)
            }
            
        }
        
        return nodes
        
        
    }
    
}
