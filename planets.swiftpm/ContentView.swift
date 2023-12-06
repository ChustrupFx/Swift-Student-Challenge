import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .landscape
    }
    
    
}

struct ContentView: View {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    var body: some View {
        PlanetView()
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
