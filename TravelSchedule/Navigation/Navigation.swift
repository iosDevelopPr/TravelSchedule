
import Foundation

final class Navigation: ObservableObject {
    // MARK: - Properties
    static let shared = Navigation()
    @Published var path: [NavigationTypes] = []
    
    private init() {}
    
    func addView(type: NavigationTypes) {
        path.append(type)
    }
    
    func stepToRoot() {
        path.removeAll()
    }
    
    func stepBack() {
        path.removeLast()
    }
}
