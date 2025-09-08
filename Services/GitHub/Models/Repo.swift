//
//  Repo.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import Foundation

///Dane z API
struct Repo: Decodable {
    let stargazersCount: Int
    let forksCount: Int
    let watchersCount: Int
    let description: String?
}
