
import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol StationListServiceProtocol {
    func getAllStations() async throws -> AllStations
}

final class StationListService: StationListServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getAllStations() async throws -> AllStations {
        do {
            let response = try await client.getAllStations(
                query: .init(apikey: apiKey)
            )
            
            let htmlResponse = try response.ok.body.html
            let data = try await Data(collecting: htmlResponse, upTo: .max)
        
            let stationsList = try JSONDecoder().decode(AllStations.self, from: data)
            return stationsList
        } catch {
            print(String(describing: error))
            if let clientError = error as? ClientError {
                throw ErrorsType.connectionError
            }
            throw ErrorsType.serverError
        }
    }
}
