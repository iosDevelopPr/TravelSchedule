
import SwiftUI

struct CloseButtonView: View {
    // MARK: - Properties
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .foregroundStyle(.trWhiteOnly)
                    .frame(width: 26, height: 26)
                Image(system: .closeButton)
                    .resizable()
                    .foregroundColor(.trBlackOnly)
            }
            .frame(width: 30, height: 30)
        }
        .padding(.top, 57)
        .padding(.trailing, 12)
    }
}
