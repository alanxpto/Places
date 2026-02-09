import Foundation

extension URL {
    static func wikipediaPlaces(latitude: Double, longitude: Double) -> URL? {
        var components = URLComponents()
        
        components.scheme = "wikipedia"
        components.host = "places"
        
        components.queryItems = [
            URLQueryItem(name: "latitude", value: String(latitude)),
            URLQueryItem(name: "longitude", value: String(longitude))
        ]
        
        return components.url
    }
}
