//
//  OnboardingView.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Ekran powitalny (jednorazowy). Po tapnięciu „Zaczynamy” wywołuje `onComplete`.
struct OnboardingView: View {
    var onComplete: () -> Void

    var body: some View {
        ZStack {
            PortalBackground()
            VStack(spacing: DS.Spacing.xl) {
                Spacer()
                Image("AppLogo")
                    .resizable().scaledToFit()
                    .frame(width: 260, height: 260)
                    .shadow(radius: 20)
                    .accessibilityLabel("App logo")

                VStack(spacing: DS.Spacing.sm) {
                    Text("Witamy w Rick & Morty App")
                        .font(.system(.largeTitle, design: .rounded)).bold()
                        .multilineTextAlignment(.center)
                    Text("Eksploruj publiczne API, zapisuj ulubione i zabezpiecz profil Face ID. Aplikacja pokazuje moje umiejętności iOS.")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }

                Spacer()
                PrimaryButton(title: "Zaczynamy") { onComplete() }
                    .padding(.bottom, 40)
            }
        }
    }
}
