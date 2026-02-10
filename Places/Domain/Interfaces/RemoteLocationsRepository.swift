import Foundation

final class RemoteLocationsRepository: LocationsRepository {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchAll(url: String) async throws -> LocationsResponse? {
        guard let url = URL(string: url) else {
            throw LocationRepositoryError.invalidUrl
        }
        
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw LocationRepositoryError.invalidResponse
        }

        do {
            let json = try await Task {
                try JSONDecoder().decode(LocationsResponse.self, from: data)
            }.value
            
            return json
        } catch {
            throw LocationRepositoryError.decodingError
        }
    }
    
    func parseLocationsResponse(locationResponse: LocationsResponse?) -> [Location] {
        return locationResponse?.locations.map { locationResponse in
            Location(
                id: UUID(),
                name: locationResponse.name ?? "Unknown",
                lat: locationResponse.lat,
                long: locationResponse.long
            )
        } ?? []
    }
}
