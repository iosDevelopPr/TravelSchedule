
import Foundation

final class ViewTypes: ObservableObject {
    static let shared = ViewTypes()
    @Published var path: [ViewType] = []
    
    private init() {}
    
    func addView(type: ViewType) {
        path.append(type)
    }
    
    func removeAll() {
        path.removeAll()
    }
    
    func stepBack() {
        path.removeLast()
    }
}
