
import SwiftUI

@main
struct TravelScheduleApp: App {
    // MARK: - Properties
    @StateObject private var stationViewModel = StationViewModel()
    @StateObject private var stationListViewModel = StationListViewModel(dataProvider: DataProvider())
    @StateObject private var carriersViewModel = CarrierSearchViewModel(dataProvider: DataProvider())
    @StateObject private var errorsSetting = ErrorsSetting.shared
    
    @StateObject private var navigation = Navigation.shared
    @AppStorage(ApiParams.theme) private var theme =
        UserDefaults.standard.bool(forKey: ApiParams.theme)
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigation)
                .environmentObject(stationViewModel)
                .environmentObject(stationListViewModel)
                .environmentObject(carriersViewModel)
                .preferredColorScheme(theme ? .dark : .light)
        }
    }
}
