
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleInfo = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getStationSchedule(station name: String) async throws -> ScheduleInfo
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getStationSchedule(station name: String) async throws -> ScheduleInfo {
        let response = try await client.getStationSchedule(
            query: .init(apikey: apiKey, station: name)
        )
        return try response.ok.body.json
    }
}
