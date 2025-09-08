//
//  Character.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import Foundation

struct Character: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let image: String
}
