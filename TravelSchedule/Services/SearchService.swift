
import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResult = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?, transportTypes: String, transfers: Bool) async throws -> SearchResult
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String? = nil,
        transportTypes: String,
        transfers: Bool
    ) async throws -> SearchResult {
        let response = try await client.getScheduleBetweenStations(
            query: .init(
                apikey: apiKey,
                from: from,
                to: to,
                date: date ?? "",
                transport_types: transportTypes,
                transfers: transfers
            )
        )
        return try response.ok.body.json
    }
}
