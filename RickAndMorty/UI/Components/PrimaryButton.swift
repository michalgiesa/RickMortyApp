//
//  PrimaryButton.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Przycisk z obrysem np. logowania
struct PrimaryButton: View {
    let title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
        }
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(LinearGradient(colors: [
                    Color(.sRGB, red: 0.34, green: 1.0, blue: 0.61, opacity: 1),
                    Color(.sRGB, red: 0.42, green: 0.94, blue: 1.0, opacity: 1)
                ], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: Color(.sRGB, red: 0.34, green: 1.0, blue: 0.61, opacity: 0.4), radius: 12, x: 0, y: 6)
        .padding(.horizontal, 24)
    }
}
