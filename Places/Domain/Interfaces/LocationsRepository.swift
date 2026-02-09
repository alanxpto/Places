protocol LocationsRepository {
    func fetchAll(url: String) async throws -> LocationsResponse?
    func parseLocationsResponse(locationResponse: LocationsResponse?) -> [Location]
}
