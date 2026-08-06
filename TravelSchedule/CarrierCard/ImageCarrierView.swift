
import SwiftUI

struct ImageCarrierView: View {
    // MARK: - Properties
    @EnvironmentObject private var cardViewModel: CarrierCardViewModel
    
    // MARK: - Body
    var body: some View {
        AsyncImage(url: cardViewModel.carrierLogo) { result in
            switch result {
            case .failure:
                Image(.trNoIcon)
                    .font(.largeTitle)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            default:
                Image(.trNoIcon)
                    .font(.largeTitle)
            }
        }
        .frame(width: 38, height: 38)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ImageCarrierView()
        .environmentObject(CarrierCardViewModel(segment: Segment()))
}
