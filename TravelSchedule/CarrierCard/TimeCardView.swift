
import SwiftUI

struct TimeCardView: View {
    // MARK: - Properties
    @EnvironmentObject private var cardViewModel: CarrierCardViewModel

    // MARK: - Body
    var body: some View {
        HStack {
            Text(cardViewModel.departureTime)
                .font(.regular17)
            VStack {
                Divider()
                    .frame(height: 1)
                    .overlay(.trGrayOnly)
            }
            Text(cardViewModel.travelTime)
                .font(.regular12)
            VStack {
                Divider()
                    .frame(height: 1)
                    .overlay(.trGrayOnly)
            }
            Text(cardViewModel.arrivalTime)
                .font(.regular17)
        }
        .foregroundStyle(.trBlackOnly)
    }
}

#Preview {
    TimeCardView()
        .environmentObject(CarrierCardViewModel(segment: Segment()))
}
