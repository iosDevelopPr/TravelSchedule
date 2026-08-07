
import Foundation

final class CarrierCardViewModel: ObservableObject {
    
    private let dateFormatter: DateFormatter
    
    private let _startDate: String?
    private let _departureTime: Date?
    private let _travelTime: Int?
    private let _arrivalTime: Date?

    private let _carrierLogo: String
    private let _carrierTitle: String?
    
    private let _has_transfers: Bool
    private let _transfersTitle: String

    private let noInfo = "Информации нет"

    var startDate: String {
        self.startDate(date: _startDate)
    }
    
    var departureTime: String {
        return self.departureTime(date: _departureTime)
    }
    
    var travelTime: String {
        return self.travelTime(intervalTime: _travelTime)
    }
    
    var arrivalTime: String {
        return self.arrivalTime(date: _arrivalTime)
    }

    var carrierLogo: URL? {
        URL(string: _carrierLogo)
    }
    
    var carrierTitle: String {
        _carrierTitle ?? noInfo
    }
    
    var has_transfers: Double {
        return _has_transfers ? 1 : 0
    }
    
    var transfersTitle: String {
        "С пересадкой в \(_transfersTitle)"
    }

    init(segment: Segment) {
        self.dateFormatter = DateFormatter()
        
        self._startDate = segment.start_date
        self._departureTime = segment.departure
        self._travelTime = segment.duration
        self._arrivalTime = segment.arrival

        self._carrierLogo = segment.thread?.carrier?.logo ?? ""
        self._carrierTitle = segment.thread?.carrier?.title
        
        self._has_transfers = segment.has_transfers ?? false
        self._transfersTitle = segment.transfers?.first?.title ?? ""
    }
    
    private func startDate(date: String?) -> String {
        guard let date else { return "" }
        
        self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let localDate = dateFormatter.date(from: date) ?? Date()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        
        return self.dateFormatter.string(from: localDate)
    }
    
    private func departureTime(date: Date?) -> String {
        var localDate = Date()
        if let date {
            localDate = date
        }
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: localDate)
    }
    
    private func travelTime(intervalTime: Int?) -> String {
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
    
    private func arrivalTime(date: Date?) -> String {
        var localDate = Date()
        if let date {
            localDate = date
        }
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: localDate)
    }
}
