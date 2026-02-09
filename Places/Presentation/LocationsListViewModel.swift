import Combine
import Foundation

@MainActor
final class LocationsListViewModel: ObservableObject {
    private let locationsRepository: LocationsRepository

    @Published var locations: [Location] = []
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var showError = false

    init(locationsRepository: LocationsRepository) {
        self.locationsRepository = locationsRepository
    }
    
    func getAllLocations() async {
        do {
            isLoading = true
            
            let response = try await locationsRepository.fetchAll(
                url: Constants.locationsUrl
            )
            
            locations = locationsRepository.parseLocationsResponse(locationResponse: response)
            
            isLoading = false
        } catch {
            let error = error as? LocationRepositoryError ?? .unknownError
            
            errorMessage = error.userMessage
            
            showError = true
            isLoading = false
            
            locations = []
        }
    }
    
    func createNewLocation(name: String, latitude: String, longitude: String) -> Location? {
        guard !name.isEmpty,
              let lat = Double(latitude),
              let long = Double(longitude),
              (-90...90).contains(lat),
              (-180...180).contains(long) else {
            return nil
        }

        return Location(id: UUID(), name: name, lat: lat, long: long)
    }
    
    func addLocation(location: Location) {
        locations.append(location)
    }
    
    func didSelect(location: Location, openUrl: @escaping (URL) -> Void) {
        if let url = URL.wikipediaPlaces(latitude: location.lat, longitude: location.long) {
            openUrl(url)
        }
    }
}
