protocol LocationsRepository {
    func fetchAll(url: String) async throws -> LocationsResponse?
}
