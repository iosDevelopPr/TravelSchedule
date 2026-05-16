
import Foundation

final class TravelViewModel: ObservableObject {
    @Published var settlements: [Settlement] = []
    @Published var stations: [Station] = []
    
    @Published var fromSettlement: Settlement?
    @Published var fromStation: Station?
    
    @Published var toSettlement: Settlement?
    @Published var toStation: Station?
    
    @Published var carriersList: [Segment] = []
    @Published var filteredCarriersList: [Segment] = []
    
    @Published var isMorning = false
    @Published var isAfternoon = false
    @Published var isEvening = false
    @Published var isNight = false
    @Published var isHasTransfers: Bool?
    
    @Published var isFilter: Bool = false
    @Published var isLoading: Bool = true
    
    @Published var isError: ErrorsType?
    
    private let viewTypes = ViewTypes.shared
    private let dataProvider: DataProviderProtocol
    private let dateFormatter: DateFormatter
    
    init() {
        dataProvider = DataProvider()
        dateFormatter = DateFormatter()
        
        Task { await loadCities() }
    }
    
    func setSettlement(settlement: Settlement, direction: Direction) {
        let allStations = settlement.stations ?? []
        stations = allStations.filter { $0.station_type == "train_station" || $0.transport_type == "train" }
        stations.sort { $0.title ?? "" < $1.title ?? "" }
        
        switch direction {
        case .from:
            self.fromSettlement = settlement
        case .to:
            self.toSettlement = settlement
        }
    }
    
    func setStation(station: Station, direction: Direction) {
        switch direction {
        case .from:
            self.fromStation = station
        case .to:
            self.toStation = station
        }
    }
    
    func getNameSettlement(direction: Direction) -> String {
        switch direction {
        case .from:
            return fromSettlement?.title ?? ""
        case .to:
            return toSettlement?.title ?? ""
        }
    }
    
    func getNameStation(direction: Direction) -> String {
        switch direction {
        case .from:
            return fromStation?.title ?? ""
        case .to:
            return toStation?.title ?? ""
        }
    }
    
    func changeDirection() {
        swap(&fromSettlement, &toSettlement)
        swap(&fromStation, &toStation)
    }
    
    func getSearchEnable() -> Bool {
        fromStation != nil || toStation != nil
    }
    
    func getTitleCarrier() -> String {
        let nameFrom = getNameSettlement(direction: .from)
        let nameTo = getNameSettlement(direction: .to)
        
        let nameStationFrom = getNameStation(direction: .from)
        let nameStationTo = getNameStation(direction: .to)
        
        let titleCarrier =
            (nameStationFrom.hasPrefix(nameFrom + " (") ? nameStationFrom : nameFrom + " (" + nameStationFrom + ")" ) + " → " +
            (nameStationTo.hasPrefix(nameTo + " (") ? nameStationTo : nameTo + " (" + nameStationTo + ")")
        
        return titleCarrier
    }
    
    func addView(type: ViewType) {
        viewTypes.addView(type: type)
    }
    
    func stepToRoot() {
        viewTypes.removeAll()
    }
    
    func stepBack() {
        viewTypes.stepBack()
    }
    
    func startDate(date: String?) -> String {
        guard let date else { return "" }
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let localDate = dateFormatter.date(from: date) ?? Date()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        
        return dateFormatter.string(from: localDate)
    }
    
    func departureTime(date: Date?) -> String {
        var localDate = Date()
        if let date {
            localDate = date
        }
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: localDate)
    }
    
    func travelTime(intervalTime: Int?) -> String {
        let hours = (intervalTime ?? 0) / 3600
        let hourString: String
        
        switch hours % 10 {
        case 1:
            hourString = "час"
        case 2, 3, 4:
            hourString = "часа"
        default:
            hourString = "часов"
        }
        let finalHours = (hours % 100 > 10 && hours % 100 < 20) ? "\(hours) часов" : "\(hours) \(hourString)"
        
        return finalHours
    }
    
    func arrivalTime(date: Date?) -> String {
        var localDate = Date()
        if let date {
            localDate = date
        }
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: localDate)
    }
    
    func getSearchSettings() -> SearchSettings {
        let searchSettings = SearchSettings()
        
        searchSettings.isMorning = isMorning
        searchSettings.isAfternoon = isAfternoon
        searchSettings.isEvening = isEvening
        searchSettings.isNight = isNight
        
        searchSettings.isHasTransfers = isHasTransfers
        
        return searchSettings
    }
    
    func setSearchSettings(searchSettings: SearchSettings) {
        isMorning = searchSettings.isMorning
        isAfternoon = searchSettings.isAfternoon
        isEvening = searchSettings.isEvening
        isNight = searchSettings.isNight

        isHasTransfers = searchSettings.isHasTransfers
        
        isFilter = isMorning || isAfternoon || isEvening || isNight || isHasTransfers == true || isHasTransfers == false
        
        Task {
            await searchCarrier()
        }
    }
    
    func routeFiltering() {
        
        if !isFilter { return }
        
        let calendar = Calendar.current
        
        let morningRoutes = isMorning ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            
            let startHour = calendar.component(.hour, from: departure)
            if (6 ..< 12).contains(startHour) {
                return true
            } else { return false }
        } : []

        let afternoonRoutes = isAfternoon ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            let startHour = calendar.component(.hour, from: departure)
            if (12 ..< 18).contains(startHour) {
                return true
            } else { return false }
        } : []

        let eveningRoutes = isEvening ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            let startHour = calendar.component(.hour, from: departure)
            if (18 ..< 24).contains(startHour) {
                return true
            } else { return false }
        } : []

        let nightRoutes = isNight ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            let startHour = calendar.component(.hour, from: departure)
            if (.zero ..< 6).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        var outputRoutes = [morningRoutes, afternoonRoutes, eveningRoutes, nightRoutes].flatMap { $0 }
        outputRoutes.sort(by: { $0.departure ?? Date() < $1.departure ?? Date()})
        
        filteredCarriersList = isHasTransfers != false ? outputRoutes :
            outputRoutes.filter { $0.has_transfers != true }
    }
    
    @MainActor
    private func loadCities() async {
        var stationList: [Settlement] = []
        let testSettlements = ["Москва", "Санкт-Петербург", "Сочи", "Уфа", "Краснодар", "Казань", "Омск", "Владивосток"]
        
        do {
            let allStation = try await dataProvider.getStationList()
            stationList = allStation.countries?
                .flatMap { $0.regions ?? []}
                .flatMap { $0.settlements ?? [] }
                .filter { testSettlements.contains($0.title ?? "") } ?? []
            
            settlements = stationList.filter { $0.title != "" }
            isLoading = settlements.isEmpty
            settlements.sort { $0.title ?? "" < $1.title ?? "" }
        } catch {
            isError = error as? ErrorsType
            addView(type: .errorView)
        }
    }
    
    @MainActor
    func searchCarrier() async {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        guard let fromCode = fromStation?.codes?.yandex_code,
              let toCode = toStation?.codes?.yandex_code else { return }
        
        do {
            let searchResult = try await dataProvider.getSearchResult(
                fromCode: fromCode,
                toCode: toCode,
                date: date,
                transportTypes: "train",
                transfers: true
            )
            
            carriersList = searchResult.segments ?? []
            carriersList = carriersList.filter() {
                guard $0.thread != nil else { return false }
                return true
            }
            filteredCarriersList = carriersList
            routeFiltering()
            
        } catch {
            isError = error as? ErrorsType
            addView(type: .errorView)
        }
        
        isLoading = false
    }
}
