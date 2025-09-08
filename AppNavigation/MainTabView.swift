//
//  MainTabView.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Główne zakładki aplikacji: Discover, Favorites, Profile.
struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack { DiscoverView() }
                .tabItem { Label("Discover", systemImage: "sparkles") }

            NavigationStack { FavoritesView() }
                .tabItem { Label("Favorites", systemImage: "star.fill") }

            NavigationStack { ProfileView() }
                .tabItem { Label("Profile", systemImage: "person.crop.circle") }
        }
    }
}
