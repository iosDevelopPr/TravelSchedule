
import SwiftUI

@main
struct TravelScheduleApp: App {
    
    @StateObject private var viewModel = TravelViewModel()
    @AppStorage(ApiParams.theme) private var isDarkModeOn = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
