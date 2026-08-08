
import Foundation

final class StationListViewModel: ObservableObject {
    // MARK: - Properties
    @Published var settlements: [Settlement] = []
    @Published var isLoading: Bool = true
    
    private let testSettlement =
        ["Москва", "Санкт-Петербург", "Сочи", "Уфа", "Краснодар", "Казань", "Омск", "Владивосток"]
    
    private let dataProvider: DataProviderStationProtocol

    init(dataProvider: DataProviderStationProtocol) {
        self.dataProvider = dataProvider
        
        Task { await loadCities() }
    }
    
    @MainActor
    private func loadCities() async {
        var stationList: [Settlement] = []
        
        do {
            let allStations = try await dataProvider.getStationList()
            stationList = allStations.countries?
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
                .filter { testSettlement.contains($0.title ?? "") } ?? []
            
            settlements = stationList.filter { $0.title != "" }
            settlements.sort { $0.title ?? "" < $1.title ?? "" }
            
            isLoading = false
        } catch {
            ErrorsSetting.shared.isError = error as? ErrorsType
            Navigation.shared.addView(type: .error)
        }
    }
    
    func getCities(cityName: String) -> [Settlement] {
        return cityName.isEmpty ? settlements : settlements.filter {
            $0.title?.contains(cityName.capitalized) ?? false
        }
    }
    
    func getStationList(settlement: Settlement) -> [Station] {
        let allStations = settlement.stations ?? []
        var stations = allStations.filter {
            $0.station_type == "train_station" || $0.station_type == "train" || $0.station_type == "station"
        }
        stations.sort {
            $0.title ?? "" < $1.title ?? ""
        }
        
        return stations
    }
    
    func getStations(direction: Direction, stationViewModel: StationViewModel, stationName: String) -> [Station] {
        let settlement = stationViewModel.getSettlement(direction: direction)
        guard let settlement else { return [] }
        
        let allStations = getStationList(settlement: settlement)
        
        if stationName.isEmpty {
            return allStations
        } else {
            let stations = allStations.filter {
                $0.title?.contains(stationName.capitalized) ?? false
            }
            return stations
        }
    }
    
    func isSettlementsNotEmpty() -> Bool {
        !settlements.isEmpty
    }
}
