import Testing
import Foundation

struct URLWikipediaTests {
    @Test("The URL is created correctly with the coordinates")
    func testThatURLIsCreatedCorrectlyWithTheCoordinates() {
        let url = URL.wikipediaPlaces(latitude: 12.3231, longitude: 9.8173)
        #expect(url?.absoluteString == "wikipedia://places?latitude=12.3231&longitude=9.8173")
    }
}
