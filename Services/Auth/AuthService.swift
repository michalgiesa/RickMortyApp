//
//  AuthService.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import Foundation
import LocalAuthentication

protocol AuthService {
    func login(email: String, password: String) async throws -> String // token
    func biometricLogin() async throws -> String
}

/// Mock
struct MockAuthService: AuthService {
    func login(email: String, password: String) async throws -> String {
        try await Task.sleep(nanoseconds: 400_000_000)
        guard email.contains("@"), password.count >= 4 else { throw AuthError.invalidCredentials }
        return "mock-token-\(UUID().uuidString)"
    }

    func biometricLogin() async throws -> String {
        let ctx = LAContext()
        var error: NSError?
        guard ctx.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            throw AuthError.biometricsUnavailable
        }
        let reason = "Zaloguj się przy użyciu Face ID"
        try await ctx.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
        return "biometric-token-\(UUID().uuidString)"
    }

    enum AuthError: LocalizedError {
        case invalidCredentials, biometricsUnavailable, cancelled
        var errorDescription: String? {
            switch self {
            case .invalidCredentials: return "Nieprawidłowy e-mail lub hasło."
            case .biometricsUnavailable: return "Biometria niedostępna."
            case .cancelled: return "Anulowano."
            }
        }
    }
}
