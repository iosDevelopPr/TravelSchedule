
import SwiftUI

struct CarrierInfoView: View {
    // MARK: - Properties
    @EnvironmentObject private var carriersViewModel: CarrierSearchViewModel

    private let titleNavigation = "Информация о перевозчике"
    private let titleEmail = "E-mail"
    private let titlePhone = "Телефон"
    
    // MARK: - Body
    var body: some View {
        ZStack {
            
            Color.trWhite.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                CarrierLogoView()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(carriersViewModel.carrierTitle)
                        .font(.bold24)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(titleEmail)
                            .font(.regular17)
                        Text(carriersViewModel.email)
                            .font(.regular12)
                            .foregroundStyle(.trBlue)
                    }
                    .padding(.top, 0)
                    VStack(alignment: .leading, spacing: 0) {
                        Text(titlePhone)
                            .font(.regular17)
                        Text(carriersViewModel.phone)
                            .font(.regular12)
                            .foregroundStyle(.trBlue)
                    }
                    .padding(.top, 8)
                }
                Spacer()
            }
            .padding(16)
        }
        .toolbarRole(.editor)
        .navigationTitle(titleNavigation)
    }
}

#Preview {
    CarrierInfoView()
}
