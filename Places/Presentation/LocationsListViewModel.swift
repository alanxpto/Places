import Combine
import Foundation

final class LocationsListViewModel: ObservableObject {
    private let locationsRepository: LocationsRepository
    @Published var locations: [Location] = []
    
    init(locationsRepository: LocationsRepository) {
        self.locationsRepository = locationsRepository
    }
    
    func getAllLocations() async {
        do {
            let response = try await locationsRepository.fetchAll()
            
            await MainActor.run {
                locations = response?.locations.map { locationResponse in
                    Location(
                        id: UUID(),
                        name: locationResponse.name ?? "Unknown",
                        lat: locationResponse.lat,
                        long: locationResponse.long
                    )
                } ?? []
            }
        } catch {
            
        }
    }
}
