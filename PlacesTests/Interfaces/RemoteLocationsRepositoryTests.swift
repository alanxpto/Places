import Testing
import Foundation

struct RemoteLocationsRepositoryTests {
    @Test("The locations response is parsed to location")
    func testThatLocationsResponseIsParsedToLocation() {
        let sut = RemoteLocationsRepository()
        
        let parsed = sut.parseLocationsResponse(locationResponse: MockLocationsResponse.locationsResponse)
        
        #expect(parsed.count == 3)
        #expect(parsed[0].name == "Amsterdam")
        #expect(parsed[1].lat == 19.0823998)
        #expect(parsed[2].long == 12.523785)
    }
}
