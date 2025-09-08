# RickMortyApp

![iOS](https://img.shields.io/badge/iOS-15%2B-informational)
![SwiftUI](https://img.shields.io/badge/SwiftUI-%E2%9D%A4%EF%B8%8F-orange)
[![CI](https://github.com/michalgiesa/RickMortyApp/actions/workflows/ci.yml/badge.svg)](https://github.com/michalgiesa/RickMortyApp/actions)

---

Struktura projektu
RickAndMorty/
├─ RickAndMortyApp.swift
├─ Core/
│  ├─ App/                # AppViewModel, SessionController
│  ├─ DesignSystem/       # DesignSystem, PortalBackground
│  ├─ Networking/         # APIClient, HTTPError
│  ├─ Persistence/        # SecureStore (Keychain)
│  └─ Utilities/          # Haptics, Extensions
├─ Services/
│  ├─ Auth/
│  ├─ RickAndMorty/       # Service + Models/Character
│  └─ GitHub/             # Service + Models/Repo
├─ Features/
│  ├─ Onboarding/
│  ├─ Auth/               # AuthView, AuthViewModel
│  ├─ Discover/           # DiscoverView, DiscoverViewModel
│  ├─ Favorites/          # FavoritesStore, FavoritesView
│  └─ Profile/            # ProfileView, AboutGitHubView
├─ AppNavigation/         # MainTabView
├─ UI/Components/         # PrimaryButton, VisualEffectBlur
├─ Resources/             # Assets, Localizations, Info.plist
├─ Config/                # .swiftlint.yml, .swiftformat
└─ .github/workflows/     # ci.yml

Architektura

MVVM + Services + Core
View (SwiftUI) – czysty UI bez logiki sieciowej.
ViewModel (ObservableObject) – stan, akcje, łączenie serwisów z widokami.
Services – RickAndMortyService, GitHubService, AuthService.
Core – APIClient, SecureStore, DesignSystem, Utilities.
App layer – AppViewModel (routing), SessionController (sesja).
Przepływ danych: View ⇄ ViewModel → Service → APIClient → URLSession.

API
Rick & Morty
GET https://rickandmortyapi.com/api/character?page={n}
Model: Character { id, name, status, image }
