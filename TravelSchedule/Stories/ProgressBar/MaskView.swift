
import SwiftUI

struct MaskView: View {
    // MARK: - Properties
    let numberOfSections: Int
    
    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(0 ..< numberOfSections, id: \.self) { _ in
                MaskFragmentView()
            }
        }
    }
}

#Preview {
    MaskView(numberOfSections: 5)
}
