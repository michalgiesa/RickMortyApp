//
//  DiscoverView.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Siatka (adaptive) kafelków postaci. Kafelki mają automatyczną wysokość (kwadraty) i równe marginesy.
struct DiscoverView: View {
    @StateObject private var vm = DiscoverViewModel()
    @EnvironmentObject var favorites: FavoritesStore

    private let spacing: CGFloat = 16
    private let minTile: CGFloat = 160
    private let maxTile: CGFloat = 240

    var body: some View {
        VStack(spacing: spacing) {
            Picker("Status", selection: $vm.statusFilter) {
                ForEach(StatusFilter.allCases) { filter in
                    Text(filter.title).tag(filter)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, spacing)

            ScrollView {
                if vm.filteredItems.isEmpty && !vm.isLoading {
                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.badge.questionmark")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        Text("No characters match the selected status.")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 80)
                } else {
                    LazyVGrid(
                        columns: [
                            GridItem(.adaptive(minimum: minTile, maximum: maxTile), spacing: spacing)
                        ],
                        spacing: spacing
                    ) {
                        ForEach(vm.filteredItems) { c in
                            VStack(spacing: 8) {
                                ZStack(alignment: .topTrailing) {
                                    AsyncImage(url: URL(string: c.image)) { phase in
                                        switch phase {
                                        case .success(let img): img.resizable().scaledToFill()
                                        case .empty: ProgressView()
                                        case .failure: Color.gray
                                        @unknown default: Color.gray
                                        }
                                    }
                                    .aspectRatio(1, contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))

                                    Button { favorites.toggle(character: c) } label: {
                                        Image(systemName: favorites.isFavorite(id: c.id) ? "heart.fill" : "heart")
                                            .padding(8)
                                            .background(.ultraThinMaterial, in: Circle())
                                    }
                                    .padding(8)
                                }

                                Text(c.name).font(.headline).lineLimit(1)
                                Text(c.status).font(.caption).foregroundStyle(.secondary)
                            }
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
                        }
                    }
                    .padding(.horizontal, spacing)
                    .padding(.vertical, spacing)
                }
            }
        }
        .background(PortalBackground())
        .navigationTitle("Discover")
        .task { vm.load() }
    }
}

