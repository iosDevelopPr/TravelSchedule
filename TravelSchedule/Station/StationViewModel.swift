
import Foundation

final class StationViewModel: ObservableObject {
    // MARK: - Properties
    @Published var fromSettlement: Settlement?
    @Published var fromStation: Station?
    
    @Published var toSettlement: Settlement?
    @Published var toStation: Station?

    func setSettlement(settlement: Settlement, direction: Direction) {
        switch direction {
        case .from:
            if self.fromSettlement != settlement {
                self.fromStation = nil
            }
            self.fromSettlement = settlement
        case .to:
            if self.toSettlement != settlement {
                self.toStation = nil
            }
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
    
    func getSettlement(direction: Direction) -> Settlement? {
        switch direction {
        case .from:
            return fromSettlement
        case .to:
            return toSettlement
        }
    }
    
    func getStation(direction: Direction) -> Station? {
        switch direction {
        case .from:
            return fromStation
        case .to:
            return toStation
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
    
    func getNameDestination(direction: Direction) -> String {
        let nameSettlement = getNameSettlement(direction: direction)
        let nameStation = getNameStation(direction: direction)
        
        if nameSettlement == "".trimmingCharacters(in: .whitespacesAndNewlines)
           && nameStation == "".trimmingCharacters(in: .whitespacesAndNewlines)
        {
            return direction.placeholder
        } else {
            return nameStation.hasPrefix(nameSettlement + " (") ? nameStation :
                nameSettlement + " (\(nameStation))"
        }
    }
    
    func getSearchEnable() -> Bool {
        fromStation != nil && toStation != nil
    }
    
    func getNameRoute() -> String {
        let nameFrom = getNameSettlement(direction: .from)
        let nameTo = getNameSettlement(direction: .to)
        
        let nameStationFrom = getNameStation(direction: .from)
        let nameStationTo = getNameStation(direction: .to)
        
        let nameRoute =
            (nameStationFrom.hasPrefix(nameFrom + " (") ? nameStationFrom : nameFrom + " (" + nameStationFrom + ")") + " → " +
            (nameStationTo.hasPrefix(nameTo + " (") ? nameStationTo : nameTo + " (" + nameStationTo + ")")
        
        return nameRoute
    }
}
