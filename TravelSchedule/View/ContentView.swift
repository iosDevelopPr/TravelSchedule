
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
                            Image(.scheduleTab)
                                .renderingMode(.template)
                        }
                        .environmentObject(viewModel)
                    SettingsView()
                        .tabItem {
                            Image(.settingsTab)
                                .renderingMode(.template)
                        }
                        .environmentObject(viewModel)
                }
                .navigationDestination(for: ViewType.self) { path in
                    switch path {
                    case ViewType.agreementView:
                        AgreementView()
                    case ViewType.fromCityView:
                        CityView(direction: .from)
                            .environmentObject(viewModel)
                    case ViewType.toCityView:
                        CityView(direction: .to)
                            .environmentObject(viewModel)
                    case ViewType.fromStationView:
                        StationView(direction: .from)
                            .environmentObject(viewModel)
                    case ViewType.toStationView:
                        StationView(direction: .to)
                            .environmentObject(viewModel)
                    case ViewType.carrierView:
                        CarrierView()
                            .environmentObject(viewModel)
                    case .carrierInfoView:
                        CarrierInfoView()
                    case .filtersView:
                        FiltersView(searchSettings: viewModel.getSearchSettings())
                            .environmentObject(viewModel)
                    case .errorView:
                        ErrorsView(error: viewModel.isError ?? .serverError)
                    }
                }
            }
        }
        .tint(.trBlack)
    }
}

#Preview {
    ContentView()
        .environmentObject(TravelViewModel())
}
