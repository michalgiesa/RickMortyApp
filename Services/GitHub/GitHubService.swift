//
//  GitHubService.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import Foundation

/// Serwis do pobierania informacji o repozytorium GitHub (bez auth).
protocol GitHubService {
    /// - Parameters:
    /// - owner: właściciel repozytorium.
    /// - name: nazwa repozytorium.
    /// - Returns: Struktura `Repo`.
    func repo(owner: String, name: String) async throws -> Repo
}

struct DefaultGitHubService: GitHubService {
    private let api: APIClient
    init(api: APIClient = DefaultAPIClient(baseURL: URL(string: "https://api.github.com")!)) { self.api = api }

    func repo(owner: String, name: String) async throws -> Repo {
        try await api.request(Endpoint(path: "repos/\(owner)/\(name)"))
    }
}
