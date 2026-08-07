
import SwiftUI

struct ErrorsView: View {
    // MARK: - Properties
    private let error: ErrorsType
    
    init(error: ErrorsType) {
        self.error = error
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                Image(uiImage: error.image)
                Text(error.title)
                    .font(.bold24)
            }
        }
    }
}

#Preview {
    ErrorsView(error: .connectionError)
}
