
import SwiftUI

struct SettlementContentView: View {
    // MARK: - Properties
    @EnvironmentObject private var stationViewModel: StationViewModel
    @EnvironmentObject private var stationListViewModel: StationListViewModel
    @EnvironmentObject private var navigation: Navigation

    let direction: Direction

    @Binding var findName: String
    
    var settlements: [Settlement] {
        stationListViewModel.getCities(cityName: findName)
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(settlements, id: \.self) { settlement in
                    ZStack {
                        HStack {
                            Text(settlement.title ?? "")
                                .font(.regular17)
                                .padding([.top, .bottom], 19)
                            Spacer()
                            Image(system: .chevronRight)
                                .imageScale(.large)
                        }
                        .foregroundStyle(.trBlack)
                    }
                    .onTapGesture {
                        stationViewModel.setSettlement(settlement: settlement, direction: direction)
                        switch direction {
                        case .from:
                            navigation.addView(type: .fromStation)
                        case .to:
                            navigation.addView(type: .toStation)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SettlementContentView(direction: .from, findName: .constant(""))
}
