
import SwiftUI

struct CarrierCardView: View {
    // MARK: - Properties
    @State private var cardViewModel: CarrierCardViewModel
    
    init(segment: Segment) {
        self.cardViewModel = CarrierCardViewModel(segment: segment)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trLightGray
            VStack(spacing: 14) {
                HeaderCardView()
                    .environmentObject(cardViewModel)
                TimeCardView()
                    .environmentObject(cardViewModel)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}

#Preview {
    CarrierCardView(segment: Segment())
}
