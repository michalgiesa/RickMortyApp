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

## Aktualizacja aplikacji na macOS

1. **Zaktualizuj kod źródłowy** – w terminalu przejdź do katalogu projektu i pobierz najnowsze zmiany z repozytorium, np. `git pull origin main`.
2. **Zainstaluj zależności** – otwórz plik `RickAndMorty.xcodeproj` w Xcode; menedżer pakietów automatycznie dociągnie wymagane paczki Swift Package Manager.
3. **Przebuduj projekt** – w Xcode wybierz schemat docelowy (np. „RickAndMorty (iOS)” lub „RickAndMorty (macOS)”), a następnie naciśnij `Cmd + B`, aby zbudować aplikację z nowym kodem.
4. **Uruchom w symulatorze lub na urządzeniu** – użyj `Cmd + R`, aby uruchomić aplikację i upewnić się, że działa poprawnie po aktualizacji.
5. **Zainstaluj build na Macu** – jeżeli tworzysz aplikację Catalyst/macOS, wybierz schemat macOS i użyj `Product > Archive`, aby wygenerować build do dystrybucji poprzez Xcode Organizer lub TestFlight.
6. **Opcjonalnie odśwież zależności** – jeżeli korzystasz z narzędzi takich jak CocoaPods, uruchom odpowiednie polecenia (`pod install`, `pod update`) przed ponownym otwarciem projektu.

W przypadku aplikacji pobranej z App Store wystarczy otworzyć **App Store** na Macu, przejść do zakładki „Aktualizacje” i zainstalować nową wersję, gdy tylko pojawi się na liście.
