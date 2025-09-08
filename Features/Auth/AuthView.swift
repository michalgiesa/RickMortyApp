//
//  AuthView.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Ekran logowania – pola e‑mail/hasło, przycisk Login oraz przycisk Face ID (gdy dostępne).
struct AuthView: View {
    @StateObject private var vm: AuthViewModel

    init(onSuccess: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: AuthViewModel(onSuccess: onSuccess))
    }

    var body: some View {
        ZStack {
            PortalBackground()
            VStack(spacing: DS.Spacing.md) {
                Spacer()
                Image("AppLogo").resizable().scaledToFit().frame(width: 160).padding(.bottom, DS.Spacing.sm)

                Text("Zaloguj się")
                    .font(.title2.bold())

                Group {
                    TextField("E-mail", text: $vm.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .textContentType(.username)
                    SecureField("Hasło", text: $vm.password)
                        .textContentType(.password)
                }
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))

                HStack(spacing: DS.Spacing.md) {
                    PrimaryButton(title: vm.isLoading ? "Logowanie..." : "Zaloguj") { vm.login() }
                        .disabled(vm.isLoading)
                    if vm.biometricsAvailable {
                        Button(action: vm.startBiometricLogin) {
                            Image(systemName: "faceid").font(.title2)
                        }
                        .frame(width: 54, height: 54)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                    }
                }

                Button("Rejestracja (wkrótce)") { }
                    .foregroundStyle(.secondary)
                Button("Nie pamiętasz hasła? (wkrótce)") { }
                    .foregroundStyle(.secondary)

                Spacer(minLength: 40)
            }
            .padding()
            .alert("Info", isPresented: $vm.showAlert) { Button("OK", role: .cancel) {} } message: { Text(vm.alertMessage) }

            if vm.blurBackground {
                Rectangle().fill(.ultraThinMaterial).ignoresSafeArea()
            }
        }
    }
}
