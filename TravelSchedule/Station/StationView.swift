
import SwiftUI

struct StationView: View {
    // MARK: - Properties
    @EnvironmentObject private var navigation: Navigation
    @EnvironmentObject private var stationListViewModel: StationListViewModel
    @EnvironmentObject private var stationViewModel: StationViewModel
    @State private var stationName: String = ""
    
    private let direction: Direction
    
    private let titleView = "Выбор станции"
    private let textNotFound = "Станция не найдена"
    
    var stations: [Station] {
        stationListViewModel.getStations(direction: direction, stationViewModel: stationViewModel, stationName: stationName)
    }

    init(direction: Direction) {
        self.direction = direction
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.trWhite.ignoresSafeArea()
            VStack {
                TextFieldView(findName: $stationName)
                
                if stations.isEmpty {
                    Spacer()
                    Text(textNotFound)
                        .font(.bold24)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(stations, id: \.self) { station in
                                ZStack {
                                    HStack {
                                        Text(station.title ?? "")
                                            .font(.regular17)
                                            .padding([.top, .bottom], 19)
                                        Spacer()
                                        Image(system: .chevronRight)
                                            .imageScale(.large)
                                    }
                                    .foregroundStyle(.trBlack)
                                }
                                .onTapGesture {
                                    stationViewModel.setStation(station: station, direction: direction)
                                    navigation.stepToRoot()
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .navigationTitle(titleView)
        .toolbarRole(.editor)
    }
}

#Preview {
    StationView(direction: .from)
}
