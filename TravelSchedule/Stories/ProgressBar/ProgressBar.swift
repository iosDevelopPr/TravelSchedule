
import SwiftUI

struct ProgressBar: View {
    // MARK: - Properties
    let numberOfSections: Int
    let progress: CGFloat
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundColor(.trWhiteOnly)
                
                RoundedRectangle(cornerRadius: .progressBarCornerRadius)
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundColor(.trBlue)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
        }
    }
}

#Preview {
    Color.trBlackOnly
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 3, progress: 0.5)
                .padding()
        )
    
}
