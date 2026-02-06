import Foundation

final class MockLocationRepository: LocationsRepository {
    private let shouldFail: Bool
    
    init(shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
    
    func fetchAll(url: String) async throws -> LocationsResponse? {
        if shouldFail {
            throw LocationRepositoryError.unkownError
        }
        
        let amsterdam = LocationResponse(name: "Amsterdam", lat: 52.3547498, long: 4.8339215)
        let mumbai = LocationResponse(name: "Mumbai", lat: 19.0823998, long: 72.8111468)
        let copenhagen = LocationResponse(name: "Copenhagen", lat: 55.6713442, long: 12.523785)
        
        return LocationsResponse(locations: [amsterdam, mumbai, copenhagen])
    }
}
