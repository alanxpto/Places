import Foundation

final class LocationsRepositoryAPI: LocationsRepository {
    private let address = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json"
    
    func fetchAll() async throws -> LocationsResponse? {
        guard let url = URL(string: address) else {
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
