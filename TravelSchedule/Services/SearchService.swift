
import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResult = Components.Schemas.Segments

protocol SearchServiceProtocol: Sendable {
    func getScheduleBetweenStations(from: String, to: String, date: String?, transportTypes: String, transfers: Bool) async throws -> SearchResult
}

actor SearchService: SearchServiceProtocol {
    private(set) var client: Client
    private(set) var apiKey: String
    
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
        do {
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
            return try await response.ok.body.json
        } catch {
            if error is ClientError {
                throw ErrorsType.connectionError
            }
            throw ErrorsType.serverError
        }
    }
}
