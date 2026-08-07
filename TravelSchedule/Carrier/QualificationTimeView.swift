
import SwiftUI

struct QualificationTimeView: View {
    // MARK: - Properties
    @EnvironmentObject private var navigation: Navigation
    @EnvironmentObject private var carriersViewModel: CarrierSearchViewModel
    
    private let textSpecify = "Уточнить время"
    
    // MARK: - Body
    var body: some View {
        VStack {
            Button {
                navigation.addView(type: .filters)
            } label: {
                HStack {
                    Text(textSpecify)
                        .font(.bold17)
                        .foregroundStyle(.trWhiteOnly)
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(carriersViewModel.isFilter ? .trRedOnly : .trBlue)
                }
            }
            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
            .background(.trBlue)
            .clipShape(.rect(cornerRadius: 16))
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    QualificationTimeView()
}
