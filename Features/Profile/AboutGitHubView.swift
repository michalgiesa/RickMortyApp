//
//  AboutGitHubView.swift
//  RickAndMorty
//
//  Created by Michał Giesa on 01/09/2025.
//

import SwiftUI

/// Wyświetla statystyki repozytorium z GitHub API.
struct AboutGitHubView: View {
    @State private var repo: Repo?
    @State private var isLoading = false

    private let owner = "michalg"
    private let name  = "RickAndMorty"

    var body: some View {
        List {
            if let r = repo {
                Section("GitHub") {
                    LabeledContent("⭐️ Stars", value: "\(r.stargazersCount)")
                    LabeledContent("🍴 Forks", value: "\(r.forksCount)")
                    LabeledContent("👀 Watchers", value: "\(r.watchersCount)")
                    if let d = r.description { Text(d).foregroundStyle(.secondary) }
                    Link("Open in GitHub", destination: URL(string: "https://github.com/\(owner)/\(name)")!)
                }
            } else if isLoading {
                ProgressView("Loading…")
            } else {
                Text("No data")
            }
        }
        .navigationTitle("About / GitHub")
        .task {
            isLoading = true
            defer { isLoading = false }
            repo = try? await DefaultGitHubService().repo(owner: owner, name: name)
        }
    }
}
