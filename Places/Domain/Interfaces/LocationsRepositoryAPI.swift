import Foundation

final class LocationsRepositoryAPI: LocationsRepository {
    func fetchAll(url: String) async throws -> LocationsResponse? {
        guard let url = URL(string: url) else {
            throw LocationRepositoryError.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let json = try JSONDecoder().decode(LocationsResponse.self, from: data)
            
            return json
        } catch {
            throw LocationRepositoryError.decodingError
        }
    }
}
