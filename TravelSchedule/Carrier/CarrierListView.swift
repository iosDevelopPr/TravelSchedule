
import SwiftUI

struct CarrierListView: View {
    // MARK: - Properties
    @EnvironmentObject private var carriersViewModel: CarrierSearchViewModel
    @EnvironmentObject private var navigation: Navigation
    
    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(carriersViewModel.filteredCarriersList, id: \.self) { segment in
                        CarrierCardView(segment: segment)
                            .frame(height: 104)
                            .onTapGesture {
                                carriersViewModel.segment = segment
                                navigation.addView(type: .carrierInfo)
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: - Preview
#Preview {
    CarrierListView()
}
