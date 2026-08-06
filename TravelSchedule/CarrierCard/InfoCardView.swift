
import SwiftUI

struct InfoCardView: View {
    // MARK: - Properties
    @EnvironmentObject private var cardViewModel: CarrierCardViewModel

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(cardViewModel.carrierTitle)
                .font(.regular17)
            Text(cardViewModel.transfersTitle)
                .font(.regular12)
                .foregroundStyle(.trRedOnly)
                .lineLimit(2)
                .opacity(cardViewModel.has_transfers)
        }
        Spacer()
        Text(cardViewModel.startDate)
            .font(.regular12)
    }
}

#Preview {
    InfoCardView()
        .environmentObject(CarrierCardViewModel(segment: Segment()))
}
