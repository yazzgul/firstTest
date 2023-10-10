import Foundation

struct Car: Hashable, Identifiable {
    let id: UUID
    let modelName: String
    let price: Int
    let imageDescription: String
}
