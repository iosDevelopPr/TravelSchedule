
import SwiftUI

struct StoriesView: View {
    // MARK: - Properties
    @EnvironmentObject private var stories: StoriesViewModel
    @Binding var showStory: Bool
    
    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 12) {
                ForEach(stories.stories) { story in
                    StoriesPreviewView(story: story)
                        .onTapGesture {
                            stories.setShown(uuid: story.id)
                            showStory = true
                        }
                }
            }
            .padding([.leading, .trailing], 16)
        }
        .scrollIndicators(.hidden)
        .frame(height: 188)
    }
}

#Preview {
    StoriesView(showStory: .constant(false))
}
