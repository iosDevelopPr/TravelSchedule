
import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

typealias Settlement = Components.Schemas.Settlement
typealias Stations = Components.Schemas.Stations
typealias Segments = Components.Schemas.Segments
typealias Carrier = Components.Schemas.Carrier

typealias Station = Components.Schemas.Station
typealias Segment = Components.Schemas.Segment

protocol DataProviderStationProtocol {
    func getStationList() async throws -> AllStations
}

protocol DataProviderSearchProtocol {
    func getSearchResult(fromCode: String, toCode: String, date: String) async throws -> SearchResult
}

final class DataProvider: DataProviderStationProtocol, DataProviderSearchProtocol {
    
    func getStationList() async throws -> AllStations {

        let client = getClient()
        guard let client else { return AllStations() }
        
        let service = StationListService(
            client: client,
            apiKey: ApiParams.apiKey
        )
        
        let allStation = try await service.getAllStations()
        return allStation
    }
    
    func getSearchResult(fromCode: String, toCode: String, date: String) async throws -> SearchResult {

        let client = getClient()
        guard let client else { return SearchResult() }
        
        let service = SearchService(
            client: client,
            apiKey: ApiParams.apiKey
        )
        
        let carriers = try await service.getScheduleBetweenStations(
            from: fromCode,
            to: toCode,
            date: date,
            transportTypes: "train",
            transfers: true
        )
        return carriers
    }
    
    func getClient() -> Client? {
        var url: URL?
        
        do {
            url = try Servers.Server1.url()
        }
        catch {
            print("Couldn't create client: \(error)")
        }
        
        guard let url else {
            return nil
        }
        
        let client = Client(
            serverURL: url,
            transport: URLSessionTransport()
        )
        
        return client
    }
}
