
import SwiftUI

struct CarrierInfoView: View {
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Spacer()
                    .toolbarRole(.editor)
                    .navigationTitle("Информация о перевозчике")

            }
            .foregroundStyle(.trBlack)
            .padding(16)
        }
    }
}

#Preview {
    CarrierInfoView()
}
