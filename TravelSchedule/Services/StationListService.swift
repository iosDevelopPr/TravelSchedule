
import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol StationListServiceProtocol: Sendable {
    func getAllStations() async throws -> AllStations
}

actor StationListService: StationListServiceProtocol {
    private(set) var client: Client
    private(set) var apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }

    func getAllStations() async throws -> AllStations {
        do {
            let response = try await client.getAllStations(
                query: .init(apikey: apiKey)
            )
            
            let htmlResponse = try await response.ok.body.html
            let data = try await Data(collecting: htmlResponse, upTo: .max)
            
            let stationsList = try JSONDecoder().decode(AllStations.self, from: data)
            return stationsList
        } catch {
            if error is ClientError {
                throw ErrorsType.connectionError
            }
            throw ErrorsType.serverError
        }
    }
}
