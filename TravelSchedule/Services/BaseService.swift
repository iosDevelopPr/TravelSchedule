
import Foundation

import OpenAPIRuntime
import OpenAPIURLSession

class BaseService {
    private(set) var client: Client
    private(set) var apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
}
