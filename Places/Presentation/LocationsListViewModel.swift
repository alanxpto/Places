import Combine
import Foundation

@MainActor
final class LocationsListViewModel: ObservableObject {
    private let locationsRepository: LocationsRepository
    
    @Published var locations: [Location] = []
    @Published var errorMessage: String?
    
    init(locationsRepository: LocationsRepository) {
        self.locationsRepository = locationsRepository
    }
    
    func getAllLocations() async {
        do {
            let response = try await locationsRepository.fetchAll()

            locations = response?.locations.map { locationResponse in
                Location(
                    id: UUID(),
                    name: locationResponse.name ?? "Unknown",
                    lat: locationResponse.lat,
                    long: locationResponse.long
                )
            } ?? []
        } catch {
            let error = error as? LocationRepositoryError ?? .unkownError
            
            errorMessage = message(for: error)
            locations = []
        }
    }
    
    func createNewLocation(name: String, latitude: String, longitude: String) -> Location? {
        guard !name.isEmpty, let lat = Double(latitude), let long = Double(longitude) else {
            return nil
        }
                
        return Location(id: UUID(), name: name, lat: lat, long: long)
    }
    
    func addLocation(location: Location) {
        locations.append(location)
    }
    
    func createUrl(latitude: Double, longitude: Double) -> URL? {
        let string = "wikipedia://places?latitude=\(latitude)&longitude=\(longitude)"
        
        guard let url = URL(string: string) else {
            return nil
        }
        
        return url
    }
    
    private func message(for error: LocationRepositoryError) -> String {
        switch error {
        case .invalidUrl:
            return "Invalid URL"
        case .decodingError:
            return "Failed to read server response"
        case .unkownError:
            return "Something went wrong"
        }
    }
}
