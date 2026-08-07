
import SwiftUI

struct MaskFragmentView: View {
    // MARK: - Body
    var body: some View {
        RoundedRectangle(cornerRadius: .progressBarCornerRadius)
            .fixedSize(horizontal: false, vertical: true)
            .frame(height: .progressBarHeight)
            .foregroundStyle(.trWhiteOnly)
    }
}

#Preview {
    MaskFragmentView()
}
