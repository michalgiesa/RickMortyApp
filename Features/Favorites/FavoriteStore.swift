//
//  FavoriteStore.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import Foundation
import SwiftUI


struct FavoritedCharacter: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let image: String

    init(from c: Character) {
        id = c.id; name = c.name; status = c.status; image = c.image
    }
}

/// Model ulubionej postaci zapisanej lokalnie (do JSON).
@MainActor
final class FavoritesStore: ObservableObject {
    @Published var items: [FavoritedCharacter] = [] { didSet { persist() } }

    private let fileURL: URL = {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        return dir.appendingPathComponent("favorites.json")
    }()

    init() { load() }

    func isFavorite(id: Int) -> Bool { items.contains { $0.id == id } }

    func toggle(character: Character) {
        if let idx = items.firstIndex(where: { $0.id == character.id }) {
            items.remove(at: idx)
        } else {
            items.append(FavoritedCharacter(from: character))
        }
    }

    private func persist() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: fileURL, options: .atomic)
        } catch { print("Favorites persist error:", error) }
    }

    private func load() {
        guard FileManager.default.fileExists(atPath: fileURL.path) else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            items = try JSONDecoder().decode([FavoritedCharacter].self, from: data)
        } catch { print("Favorites load error:", error) }
    }
}
