
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: TravelViewModel
    @ObservedObject var viewTypes = ViewTypes.shared
    
    init () {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .trWhite
        appearance.shadowColor = .trBarDivider
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack(path: $viewTypes.path) {
            ZStack {
                Color.trWhite.ignoresSafeArea()
                TabView {
                    ScheduleView()
                        .tabItem {
                            Image("ScheduleTab")
                                .renderingMode(.template)
                        }
                    SettingsView()
                        .tabItem {
                            Image("SettingsTab")
                                .renderingMode(.template)
                        }
                }
                .navigationDestination(for: ViewType.self) { path in
                    switch path {
                    case ViewType.agreementView:
                        AgreementView()
                    case ViewType.fromCityView:
                        CityView(direction: .from)
                    case ViewType.toCityView:
                        CityView(direction: .to)
                    case ViewType.fromStationView:
                        StationView(direction: .from)
                    case ViewType.toStationView:
                        StationView(direction: .to)
                    case ViewType.carrierView:
                        CarrierView()
                    case .carrierInfoView:
                        CarrierInfoView()
                    case .filtersView:
                        FiltersView(searchSettings: viewModel.getSearchSettings())
                    }
                }
            }
        }
        .tint(.trBlack)
    }
}

//#Preview {
//    ContentView()
//}

func testFetchStation() {
//    QueryExamples.getNearestStations()
//    QueryExamples.getCarrierInfo()
//    QueryExamples.getCopyright()
//    QueryExamples.getNearestCity()
//    QueryExamples.getStationSchedule()
//    QueryExamples.getScheduleBetweenStations()
//    QueryExamples.getAllStations()
//    QueryExamples.getRouteStations()
}
