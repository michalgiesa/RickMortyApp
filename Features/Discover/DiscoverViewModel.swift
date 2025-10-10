//
//  DiscoverViewModel.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Dostępne filtry statusu postaci prezentowane w widoku Discover.
enum StatusFilter: String, CaseIterable, Identifiable {
    case all
    case alive
    case dead
    case unknown

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all: return "All"
        case .alive: return "Alive"
        case .dead: return "Dead"
        case .unknown: return "Unknown"
        }
    }

    func matches(status: String) -> Bool {
        guard self != .all else { return true }
        return status.caseInsensitiveCompare(rawValue) == .orderedSame
    }
}

/// ViewModel listy postaci: ładowanie pierwszej strony i publikacja wyników.
@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var items: [Character] = []
    @Published var isLoading = false
    @Published var statusFilter: StatusFilter = .all
    private let service: RickAndMortyService

    init(service: RickAndMortyService = DefaultRickAndMortyService()) {
        self.service = service
    }

    var filteredItems: [Character] {
        items.filter { statusFilter.matches(status: $0.status) }
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
