
import SwiftUI

struct CarrierLogoView: View {
    // MARK: - Properties
    @EnvironmentObject private var carriersViewModel: CarrierSearchViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: carriersViewModel.logo)) { phase in
                switch phase {
                case .failure:
                    Image(system: .photo)
                        .font(.largeTitle)
                        .foregroundStyle(.trBlackOnly)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                default:
                    Image(system: .photo)
                        .font(.largeTitle)
                        .foregroundStyle(.trBlackOnly)
                }
            }
            .frame(width: 343, height: 104)
            .background(.trWhiteOnly)
            .clipShape(.rect(cornerRadius: 24))
        }
    }
}

#Preview {
    CarrierLogoView()
}
