
import OpenAPIRuntime
import OpenAPIURLSession

typealias Thread = Components.Schemas.ThreadStationsResponse

protocol ThreadServiceProtocol {
    func getRouteStations(uid: String) async throws -> Thread
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getRouteStations(uid: String) async throws -> Thread {
        let response = try await client.getRouteStations(
            query: .init(apikey: apiKey, uid: uid)
        )
        
        return try response.ok.body.json
    }
}
