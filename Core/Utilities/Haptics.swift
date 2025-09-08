//
//  Haptics.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import UIKit

enum Haptics {
    static func success() { UINotificationFeedbackGenerator().notificationOccurred(.success) }
    static func error() { UINotificationFeedbackGenerator().notificationOccurred(.error) }
    static func light() { UIImpactFeedbackGenerator(style: .light).impactOccurred() }
}
