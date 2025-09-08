//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

@main
struct RickAndMortyAppApp: App {
    @StateObject private var appVM = AppViewModel()
    @StateObject private var favorites = FavoritesStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appVM)
                .environmentObject(favorites)
                .preferredColorScheme(.dark)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var appVM: AppViewModel

    var body: some View {
        switch appVM.route {
        case .onboarding:
            OnboardingView { appVM.completedOnboarding() }
        case .auth:
            AuthView(onSuccess: { appVM.didLogin() })
        case .main:
            MainTabView()
        }
    }
}
