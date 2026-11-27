import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appVM: AppViewModel

    var body: some View {
        List {
            Section("About") {
                NavigationLink(destination: AboutGitHubView()) {
                    Label("GitHub", systemImage: "chevron.left.slash.chevron.right")
                }
                LabeledContent("Tech Stack", value: "SwiftUI · MVVM · Keychain")
                LabeledContent("Features", value: "API · Favorites · Face ID")
            }
            Section {
                Button(role: .destructive) { appVM.logout() } label: {
                    Label("Log out", systemImage: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        .navigationTitle("Profile")
    }
}
