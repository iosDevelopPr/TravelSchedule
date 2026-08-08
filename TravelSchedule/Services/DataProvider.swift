
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

protocol DataProviderSearchProtocol: Sendable {
    func getSearchResult(fromCode: String, toCode: String, date: String) async throws -> SearchResult
}

actor DataProvider: DataProviderStationProtocol, DataProviderSearchProtocol {
    
    func getStationList() async throws -> AllStations {

        let client = getClient()
        guard let client else { return await AllStations() }
        
        let service = await StationListService(
            client: client,
            apiKey: ApiParams.apiKey
        )
        
        let allStation = try await service.getAllStations()
        return allStation
    }
    
    func getSearchResult(fromCode: String, toCode: String, date: String) async throws -> SearchResult {

        let client = getClient()
        guard let client else { return await SearchResult() }
        
        let service = await SearchService(
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
    
    private func getClient() -> Client? {
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
