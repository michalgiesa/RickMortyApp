//
//  SessionController.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI
import LocalAuthentication

/// Kontroler sesji użytkownika.
/// Przechowuje flagę onboarding i token sesji (w Keychain) oraz zapewnia metody restore/save/logout.
@MainActor
final class SessionController {
    static let shared = SessionController()
    /// Flaga czy onboarding został ukończony (AppStorage → UserDefaults).
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    private let keychain = SecureStore(service: "com.michalgiesa.RickAndMortyApp")

    private(set) var token: String?

    func restore() async -> Bool {
        token = try? keychain.read(.authToken)
        return token != nil
    }

    func save(token: String) {
        self.token = token
        try? keychain.save(token, for: .authToken, protectedWithBiometrics: false)
    }

    func logout() {
        token = nil
        try? keychain.delete(.authToken)
    }
}

extension SecureStore.Key {
    static let authToken = SecureStore.Key("auth.token")
}
