
import SwiftUI

struct CarrierInfoView: View {
    
    private let titleNavigation = "Информация о перевозчике"
    
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Spacer()
                    .toolbarRole(.editor)
                    .navigationTitle(titleNavigation)

            }
            .foregroundStyle(.trBlack)
            .padding(16)
        }
    }
}

#Preview {
    CarrierInfoView()
}
