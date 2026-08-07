
import SwiftUI

struct HeaderCardView: View {
    // MARK: - Properties
    @EnvironmentObject private var cardViewModel: CarrierCardViewModel
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 18) {
            ImageCarrierView()
            InfoCardView()
        }
        .foregroundStyle(.trBlackOnly)
    }
}

#Preview {
    HeaderCardView()
        .environmentObject(CarrierCardViewModel(segment: Segment()))
}
