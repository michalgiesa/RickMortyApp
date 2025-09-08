//
//  AuthViewModel.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI
import LocalAuthentication

/// ViewModel ekranu logowania – zarządza loginem, FaceID oraz komunikatami.
@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var biometricsAvailable = false
    @Published var blurBackground = false

    private let auth: AuthService
    private let session: SessionController
    private let onSuccess: () -> Void

    init(auth: AuthService = MockAuthService(),
         session: SessionController,
         onSuccess: @escaping () -> Void) {
        self.auth = auth
        self.session = session
        self.onSuccess = onSuccess
        biometricsAvailable = LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }

    convenience init(auth: AuthService = MockAuthService(),
                     onSuccess: @escaping () -> Void) {
        self.init(auth: auth, session: SessionController.shared, onSuccess: onSuccess)
    }
    
    func login() {
        Task {
            isLoading = true
            defer { isLoading = false }
            do {
                let token = try await auth.login(email: email, password: password)
                session.save(token: token)
                onSuccess()
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    func startBiometricLogin() {
        blurBackground = true
        Task { @MainActor in
            defer { blurBackground = false }
            do {
                let ctx = LAContext()
                guard ctx.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) else {
                    throw MockAuthService.AuthError.biometricsUnavailable
                }
                try await ctx.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                             localizedReason: NSLocalizedString("faceid.reason", comment: ""))

                let token = "biometric-token-\(UUID().uuidString)"
                SessionController.shared.save(token: token)   // zapis bez biometrii
                Haptics.success()
                onSuccess()                                   // przejście do MainTab
            } catch {
                alertMessage = error.localizedDescription
                showAlert = true
                Haptics.error()
            }
        }
    }

}
