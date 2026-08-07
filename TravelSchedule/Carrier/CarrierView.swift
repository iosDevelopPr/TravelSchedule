
import SwiftUI

struct CarrierView: View {
    // MARK: - Properties
    @EnvironmentObject private var stationViewModel: StationViewModel
    @EnvironmentObject private var carriersViewModel: CarrierSearchViewModel
    
    private let textNotFound = "Вариантов нет"
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack(spacing: 16) {
                HStack {
                    Text(stationViewModel.getNameRoute())
                        .font(Font.bold24)
                    Spacer()
                }
                
                if carriersViewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    ZStack {
                        VStack {
                            if !carriersViewModel.filteredCarriersList.isEmpty {
                                CarrierListView()
                            } else {
                                Spacer()
                                Text(textNotFound)
                                    .font(.bold24)
                                Spacer()
                            }
                            
                            QualificationTimeView()
                        }
                    }
                }
            }
            .padding(16)
            .toolbarRole(.editor)
        }
    }
}

#Preview {
    CarrierView()
}
