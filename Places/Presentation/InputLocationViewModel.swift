import Foundation

final class InputLocationViewModel {
    func createNewLocation(name: String, latitude: String, longitude: String) -> Location? {
        guard !name.isEmpty, let lat = Double(latitude), let long = Double(longitude) else {
            return nil
        }
                
        return Location(id: UUID(), name: name, lat: lat, long: long)
    }
}
