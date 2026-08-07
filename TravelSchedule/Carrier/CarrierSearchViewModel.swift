
import Foundation

final class CarrierSearchViewModel: ObservableObject {
    // MARK: - Properties
    private let dataProvider: DataProviderSearchProtocol
    private let dateFormatter: DateFormatter
    
    @Published var fromStation: Station?
    @Published var toStation: Station?
    
    @Published var searchSettings: SearchSettings
    
    @Published var carriersList: [Segment] = []
    @Published var filteredCarriersList: [Segment] = []
    @Published var carrier: Carrier?
    
    @Published var isLoading: Bool = false
    
    private let noInfo = "Информации нет"
    
    var segment: Segment {
        get {
            Segment()
        }
        set {
            self.carrier = newValue.thread?.carrier
        }
    }
    
    var carrierTitle: String {
        carrier?.title ?? noInfo
    }
    
    var logo: String {
        carrier?.logo ?? ""
    }
    
    var email: String {
        carrier?.email ?? noInfo
    }
    
    var phone: String {
        carrier?.phone ?? noInfo
    }
    
    var isFilter: Bool {
        searchSettings.isFilter
    }
    
    init(dataProvider: DataProviderSearchProtocol) {
        self.dataProvider = dataProvider
        self.dateFormatter = DateFormatter()
        self.searchSettings = SearchSettings()
    }

    func setStations(stationModel: StationViewModel) {

        let fromStation = stationModel.getStation(direction: .from)
        let toStation = stationModel.getStation(direction: .to)
        
        if fromStation == nil || toStation == nil {
            carriersList.removeAll()
            filteredCarriersList.removeAll()
            return
        }
        
        self.fromStation = fromStation
        self.toStation = toStation
        
        Task {
            await searchCarriers()
        }
    }

    func getSearchSettings() -> SearchSettings {
        let searchSettings = SearchSettings()
        
        searchSettings.isMorning = self.searchSettings.isMorning
        searchSettings.isAfternoon = self.searchSettings.isAfternoon
        searchSettings.isEvening = self.searchSettings.isEvening
        searchSettings.isNight = self.searchSettings.isNight
        
        searchSettings.isHasTransfers = self.searchSettings.isHasTransfers
        
        return searchSettings
    }
    
    func setSearchSettings(searchSettings: SearchSettings) {
        self.searchSettings.isMorning = searchSettings.isMorning
        self.searchSettings.isAfternoon = searchSettings.isAfternoon
        self.searchSettings.isEvening = searchSettings.isEvening
        self.searchSettings.isNight = searchSettings.isNight
        
        self.searchSettings.isHasTransfers = searchSettings.isHasTransfers
    }
    
    func routeFiltering() {
        
        filteredCarriersList = carriersList

        guard searchSettings.isFilter else { return }

        let calendar = Calendar.current
        
        let morningRoutes = searchSettings.isMorning ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            
            let startHour = calendar.component(.hour, from: departure)
            if (6 ..< 12).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        let afternoonRoutes = searchSettings.isAfternoon ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            
            let startHour = calendar.component(.hour, from: departure)
            if (12 ..< 18).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        let eveningRoutes = searchSettings.isEvening ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            
            let startHour = calendar.component(.hour, from: departure)
            if (18 ..< 24).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        let nightRoutes = searchSettings.isNight ? carriersList.filter { segment in
            guard let departure = segment.departure else { return false }
            
            let startHour = calendar.component(.hour, from: departure)
            if (.zero ..< 6).contains(startHour) {
                return true
            } else { return false }
        } : []
        
        var outputRoutes = [morningRoutes, afternoonRoutes, eveningRoutes, nightRoutes].flatMap { $0 }
        outputRoutes.sort(by: { $0.departure ?? Date() < $1.departure ?? Date() })
        
        filteredCarriersList = searchSettings.isHasTransfers != false ? outputRoutes :
            outputRoutes.filter { $0.has_transfers != true }
    }

    @MainActor
    func searchCarriers() async {
        isLoading = true
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        guard let fromCode = fromStation?.codes?.yandex_code,
              let toCode = toStation?.codes?.yandex_code else { return }
        
        do {
            let searchResult = try await dataProvider.getSearchResult(
                fromCode: fromCode, toCode: toCode, date: date)
            
            carriersList = searchResult.segments ?? []
            carriersList = carriersList.filter() {
                guard $0.thread != nil else { return false }
                return true
            }
            
            routeFiltering()
            
        } catch {
            ErrorsSetting.shared.isError = error as? ErrorsType
            Navigation.shared.addView(type: .error)
        }
        
        isLoading = false
    }
}
