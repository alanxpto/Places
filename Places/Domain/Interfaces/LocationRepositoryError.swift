enum LocationRepositoryError: Error {
    case invalidUrl
    case decodingError
    case unknownError
    case invalidResponse
    
    var userMessage: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .decodingError:
            return "Failed to read server response"
        case .unknownError:
            return "Something went wrong"
        case .invalidResponse:
            return "Invalid server response"
        }
    }
}
