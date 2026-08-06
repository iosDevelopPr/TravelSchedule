
import SwiftUI

struct RadioRowView: View {
    // MARK: - Properties
    @Binding var isHasTransfers: Bool?
    let hasTransfers: Bool
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            HStack {
                Text(hasTransfers ? "Да" : "Нет")
                    .font(.regular17)
                Spacer()
                Image(system: isHasTransfers == hasTransfers ? .largeCircleFillCircle : .circle)
                    .onTapGesture {
                        isHasTransfers = hasTransfers
                    }
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    RadioRowView(isHasTransfers: .constant(false), hasTransfers: false)
}
