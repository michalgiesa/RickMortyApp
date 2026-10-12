import SwiftUI

enum DS {
    enum Spacing { static let xs: CGFloat = 8; static let sm: CGFloat = 12; static let md: CGFloat = 16; static let lg: CGFloat = 24; static let xl: CGFloat = 32 }
}

extension Color {
    static let portal = Color(#colorLiteral(red: 0.34, green: 1.0, blue: 0.61, alpha: 1))   //  portal
    static let space  = Color(#colorLiteral(red: 0.06, green: 0.08, blue: 0.12, alpha: 1))  //  tło
    static let neon   = Color(#colorLiteral(red: 0.42, green: 0.94, blue: 1.0, alpha: 1))
}

//struct PrimaryButton: View {
//    let title: String
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            Text(title).font(.headline).frame(maxWidth: .infinity).padding(.vertical, 14)
//        }
//        .background(.ultraThinMaterial)
//        .overlay(
//            RoundedRectangle(cornerRadius: 14).stroke(LinearGradient(colors: [.portal, .neon], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
//        )
//        .clipShape(RoundedRectangle(cornerRadius: 14))
//        .shadow(color: .portal.opacity(0.4), radius: 12, x: 0, y: 6)
//        .padding(.horizontal, DS.Spacing.lg)
//    }
//}

/// Używane globalnie jako tło dla ekranów
struct PortalBackground: View {
    @State private var rotate = false
    var body: some View {
        RadialGradient(colors: [.space, .space, .portal.opacity(0.12)],
                       center: .center, startRadius: 60, endRadius: 600)
            .ignoresSafeArea()
            .overlay(
                Circle()
                    .strokeBorder(AngularGradient(gradient: .init(colors: [.portal, .neon, .portal]),
                                                  center: .center), lineWidth: 2)
                    .blur(radius: 8)
                    .scaleEffect(1.2)
                    .rotationEffect(.degrees(rotate ? 360 : 0))
                    .animation(.linear(duration: 14).repeatForever(autoreverses: false), value: rotate)
                    .onAppear { rotate = true }
            )
    }
}
