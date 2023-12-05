import SwiftUI
import SpriteKit
import UIKit

struct PlanetView: UIViewRepresentable {
    let view: SKView = SKView()
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> some SKView {
        let scene = Scene1()
        
        view.bounds.size = .init(width: 810, height: 1080)
        view.showsFPS = true
        view.showsPhysics = true
        scene.scaleMode = .aspectFill
        scene.size = view.bounds.size
        
        view.presentScene(scene)
        
        return view
    }
    
    
    func makeCoordinator() -> PlanetViewCoordinator {
        let coordinator = PlanetViewCoordinator()
        
        return coordinator
    }
    
    

    class PlanetViewCoordinator: NSObject {
        
    }
}


