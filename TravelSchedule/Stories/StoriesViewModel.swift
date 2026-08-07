
import SwiftUI

final class StoriesViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var currentIndex: Int = 0
    @Published var evenImage: Bool = true
    
    private let bigImages: [Image]
    
    init() {
        self.stories = [
            Story(image: Image(.prev1)),
            Story(image: Image(.prev2)),
            Story(image: Image(.prev3)),
            Story(image: Image(.prev4)),
            Story(image: Image(.prev5)),
            Story(image: Image(.prev6)),
            Story(image: Image(.prev7)),
            Story(image: Image(.prev8)),
            Story(image: Image(.prev9))
        ]
        
        self.bigImages = [
            Image(.big1),
            Image(.big2),
            Image(.big3),
            Image(.big4),
            Image(.big5),
            Image(.big6),
            Image(.big7),
            Image(.big8),
            Image(.big9),
            Image(.big10),
            Image(.big11),
            Image(.big12),
            Image(.big13),
            Image(.big14),
            Image(.big15),
            Image(.big16),
            Image(.big17),
            Image(.big18)
        ]
    }
    
    public func setShown(uuid: UUID) {
        if let index = stories.firstIndex(where: { $0.id == uuid }) {
            currentIndex = index
        } else {
            currentIndex = 0
        }
        
        _setShown()
        evenImage = true
    }
    
    private func _setShown() {
        var story = stories[currentIndex]
        story.shown = true
        
        stories[currentIndex] = story
    }
    
    public func getBigImage() -> Image {
        return bigImages[currentIndex * 2 + (evenImage ? 0 : 1)]
    }
    
    public func getTitle() -> String {
        stories[currentIndex].title
    }
    
    public func getDescription() -> String {
        stories[currentIndex].description
    }
    
    public func incrementIndex() {
        if !evenImage {
            if currentIndex < 8 {
                currentIndex += 1
            } else {
                currentIndex = 0
            }
            
            _setShown()
        }
        evenImage.toggle()
    }
    
    public func decrementIndex() {
        if evenImage {
            if currentIndex > 0 {
                currentIndex -= 1
            } else {
                currentIndex = 8
            }
            
            _setShown()
        }
        evenImage.toggle()
    }
}
