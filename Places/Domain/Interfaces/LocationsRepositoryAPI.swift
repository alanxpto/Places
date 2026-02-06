import Foundation

final class LocationsRepositoryAPI: LocationsRepository {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchAll(url: String) async throws -> LocationsResponse? {
        guard let url = URL(string: url) else {
            throw LocationRepositoryError.invalidUrl
        }
        
        let (data, _) = try await session.data(from: url)
        
        do {
            let json = try await Task {
                try JSONDecoder().decode(LocationsResponse.self, from: data)
            }.value
            
            return json
        } catch {
            throw LocationRepositoryError.decodingError
        }
    }
}
