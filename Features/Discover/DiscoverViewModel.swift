//
//  DiscoverViewModel.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// ViewModel listy postaci: ładowanie pierwszej strony i publikacja wyników.
@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var items: [Character] = []
    @Published var isLoading = false
    private let service: RickAndMortyService

    init(service: RickAndMortyService = DefaultRickAndMortyService()) {
        self.service = service
    }

    func load() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                items = try await service.characters(page: 1)
            } catch {
                print("Discover load error:", error)
            }
        }
    }
}
