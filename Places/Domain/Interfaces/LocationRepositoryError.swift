enum LocationRepositoryError: Error {
    case invalidUrl
    case decodingError
    case unknownError
    
    var userMessage: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .decodingError:
            return "Failed to read server response"
        case .unknownError:
            return "Something went wrong"
        }
    }
}
