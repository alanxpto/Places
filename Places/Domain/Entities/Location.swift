import Foundation

struct Location: Identifiable {
    let id: UUID = UUID()
    let name: String?
    let lat: Double
    let long: Double
}
