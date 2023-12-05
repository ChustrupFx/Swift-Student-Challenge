import SwiftUI
import SceneKit

class Scene: SCNScene {
    
    
    
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            SceneView(scene: Scene())
        }
    }
}
