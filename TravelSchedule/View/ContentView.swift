
import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @EnvironmentObject private var navigation: Navigation
    @EnvironmentObject private var carriersViewModel: CarrierSearchViewModel
    @EnvironmentObject private var errorsSetting: ErrorsSetting

    init() {
        setupTabBarAppearance()
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $navigation.path) {
            ZStack {
                Color.trWhite.ignoresSafeArea()
                TabView {
                    ScheduleView()
                        .tabItem {
                            Image(.scheduleTab)
                                .renderingMode(.template)
                        }
                    SettingsView()
                        .tabItem {
                            Image(.settingsTab)
                                .renderingMode(.template)
                        }
                }
                .navigationDestination(for: NavigationTypes.self) { type in
                    switch type {
                    case .agreement:
                        AgreementView()
                    case .fromCity:
                        SettlementView(direction: .from)
                    case .toCity:
                        SettlementView(direction: .to)
                    case .fromStation:
                        StationView(direction: .from)
                    case .toStation:
                        StationView(direction: .to)
                    case .carrier:
                        CarrierView()
                    case .error:
                        ErrorsView(error: errorsSetting.isError ?? .serverError)
                    case .carrierInfo:
                        CarrierInfoView()
                    case .filters:
                        FiltersView(searchSettings: carriersViewModel.getSearchSettings())
                    }
                }
            }
        }
        .tint(.trBlack)
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .trWhite
        appearance.shadowColor = .trBarDivider
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    ContentView()
}
