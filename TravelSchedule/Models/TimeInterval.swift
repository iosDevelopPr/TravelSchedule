
import Foundation
//import SwiftUI

enum TimeInterval: String {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}

final class SearchSettings: ObservableObject {
    @Published var isMorning = false
    @Published var isAfternoon = false
    @Published var isEvening = false
    @Published var isNight = false
    
    @Published var isHasTransfers: Bool?
}
