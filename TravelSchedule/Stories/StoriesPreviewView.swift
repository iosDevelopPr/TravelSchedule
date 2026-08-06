
import SwiftUI

struct StoriesPreviewView: View {
    // MARK: - Properties
    var story: Story
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            story.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            
            Text(story.title)
                .lineLimit(3)
                .font(.regular12)
                .foregroundStyle(.trWhiteOnly)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .frame(width: 92, height: 140)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .strokeBorder(Color.trBlue, lineWidth: story.shown ? 0 : 4)
        }
        .cornerRadius(16)
        .opacity(story.shown ? 0.5 : 1)
    }
}

#Preview {
    StoriesPreviewView(story: Story(image: Image(.prev1)))
}
