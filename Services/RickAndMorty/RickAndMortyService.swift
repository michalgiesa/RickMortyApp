import Foundation

/// Model postaci z Rick & Morty API.
protocol RickAndMortyService {
    func characters(page: Int) async throws -> [Character]
}

struct DefaultRickAndMortyService: RickAndMortyService {
    private let api: APIClient
    init(api: APIClient = DefaultAPIClient(baseURL: URL(string: "https://rickandmortyapi.com/api")!)) { self.api = api }

    private struct CharactersResponse: Decodable { let results: [Character] }

    func characters(page: Int) async throws -> [Character] {
        let response: CharactersResponse = try await api.request(
            Endpoint(path: "character", query: [URLQueryItem(name: "page", value: "\(page)")])
        )
        return response.results
    }
}
