import Foundation

/// Klient HTTP oparty o `URLSession`, z prostym modelem Endpoint.
protocol APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

/// Domyślna, produkcyjna implementacja klienta.
struct Endpoint {
    var path: String
    var query: [URLQueryItem] = []
    var method: String = "GET"
    var headers: [String: String] = [:]
}

/// Minimalistyczny klient HTTP oparty o `URLSession`, z prostym modelem Endpoint.
struct DefaultAPIClient: APIClient {
    let baseURL: URL
    let decoder: JSONDecoder = {
        let d = JSONDecoder(); d.keyDecodingStrategy = .convertFromSnakeCase; return d
    }()

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        var comps = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)!
        if !endpoint.query.isEmpty { comps.queryItems = endpoint.query }
        var req = URLRequest(url: comps.url!)
        req.httpMethod = endpoint.method
        endpoint.headers.forEach { req.setValue($1, forHTTPHeaderField: $0) }

        let (data, resp) = try await URLSession.shared.data(for: req)
        guard let http = resp as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(T.self, from: data)
    }
}
