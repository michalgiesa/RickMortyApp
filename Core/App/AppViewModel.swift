//
//  AppViewModel.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

@MainActor
final class AppViewModel: ObservableObject {
    enum Route { case onboarding, auth, main }
    @Published var route: Route = .onboarding

    private let session: SessionController

    init(session: SessionController) {
        self.session = session
        Task { await boot() }
    }

    convenience init() {
        self.init(session: SessionController.shared)
    }

    func boot() async {
        if !session.hasSeenOnboarding { route = .onboarding; return }
        if await session.restore() { route = .main } else { route = .auth }
    }

    func completedOnboarding() { session.hasSeenOnboarding = true; route = .auth }
    func didLogin() { route = .main }
    func logout() { session.logout(); route = .auth }
}
