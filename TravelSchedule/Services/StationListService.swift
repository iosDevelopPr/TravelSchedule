
import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias AllStations = Components.Schemas.AllStationsResponse

protocol StationListServiceProtocol {
    func getAllStations() async throws -> AllStations
}

final class StationListService: BaseService, StationListServiceProtocol {
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
            if let clientError = error as? ClientError {
                throw ErrorsType.connectionError
            }
            throw ErrorsType.serverError
        }
    }
}
