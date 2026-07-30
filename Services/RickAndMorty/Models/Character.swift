import Foundation

struct Character: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: String
    let image: String
}
