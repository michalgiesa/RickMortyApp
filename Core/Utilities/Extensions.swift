//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Wspólne tło
extension View {
    func cardBackground() -> some View {
        self.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
    }
}
