
import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResult = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> SearchResult
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String? = nil) async throws -> SearchResult {
        let response = try await client.getScheduleBetweenStations(
            query: .init(
                apikey: apiKey,
                from: from,
                to: to,
                date: date ?? "")
        )
        return try response.ok.body.json
    }
}
