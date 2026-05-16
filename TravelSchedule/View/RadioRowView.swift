
import SwiftUI

struct RadioRowView: View {
    @Binding var isHasTransfers: Bool?
    let hasTransfers: Bool
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            HStack {
                Text(hasTransfers ? "Да" : "Нет")
                    .font(.regular17)
                Spacer()
                Image(systemName: isHasTransfers == hasTransfers ? "largecircle.fill.circle" : "circle")
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
