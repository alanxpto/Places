protocol LocationsRepository {
    func fetchAll() async throws -> LocationsResponse?
}
