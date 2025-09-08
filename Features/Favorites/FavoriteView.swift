//
//  FavoriteView.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Lista ulubionych postaci
struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesStore

    var body: some View {
        Group {
            if favorites.items.isEmpty {
                VStack(spacing: 8) {
                    Image(systemName: "star").font(.largeTitle)
                    Text("No favorites yet").font(.headline)
                    Text("Tap the heart on a character to add it here.")
                        .font(.caption).foregroundStyle(.secondary)
                }
                .padding(.top, 40)
            } else {
                List {
                    ForEach(favorites.items) { c in
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: c.image)) { phase in
                                switch phase {
                                case .success(let img): img.resizable().scaledToFill()
                                case .empty: Color.gray.opacity(0.2)
                                case .failure: Color.gray
                                @unknown default: Color.gray
                                }
                            }
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading) {
                                Text(c.name).font(.headline)
                                Text(c.status).font(.caption).foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete { favorites.items.remove(atOffsets: $0) }
                }
                .listStyle(.insetGrouped)
                .toolbar { EditButton() }
            }
        }
        .navigationTitle("Favorites")
    }
}
