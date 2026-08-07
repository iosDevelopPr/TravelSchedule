
import SwiftUI

struct Story: Identifiable, Equatable {
    let id: UUID
    let title: String
    let description: String
    
    let image: Image
    var shown: Bool
    
    init(image: Image, shown: Bool = false) {
        self.id = UUID()
        self.title = "Text Text Text Text Text Text Text Text Text Text Text Text"
        self.description = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        
        self.image = image
        self.shown = shown
    }
}
