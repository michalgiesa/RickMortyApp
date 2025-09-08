RickMortyApp

Architecture
MVVM + Services + Core
View (SwiftUI) – pure UI without networking logic.
ViewModel (ObservableObject) – state, actions, wiring services to views.
Services – RickAndMortyService, GitHubService, AuthService.
Core – APIClient, SecureStore, DesignSystem, Utilities.
App layer – AppViewModel (routing), SessionController (session).
Data flow: View ⇄ ViewModel → Service → APIClient → URLSession.

API
Rick & Morty
GET https://rickandmortyapi.com/api/character?page={n}
Model: Character { id, name, status, image }
