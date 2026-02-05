import Testing
import Places
import Foundation

@Suite("Locations List View Model Tests")
struct LocationsListViewModelTests {
    @Test("The locations array is empty")
    func testLocationsListViewModelInitialState() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let sut = await LocationsListViewModel(locationsRepository: mock)
        
        #expect(sut.locations.isEmpty)
    }
    
    @Test("The location list has the correct values if the API call is valid")
    func testThatLocationListHasCorrectValueWithValidAPICall() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let sut = await LocationsListViewModel(locationsRepository: mock)
        
        await sut.getAllLocations()
        
        #expect(sut.locations.count == 3)
        #expect(sut.locations[0].name == "Amsterdam")
        #expect(sut.locations[1].name == "Mumbai")
        #expect(sut.locations[2].name == "Copenhagen")
    }
    
    @Test("The location list is empty if the API call is invalid")
    func testThatLocationListIsEmptyWithInvalidAPICall() async throws {
        let mock = MockLocationRepository(shouldFail: true)
        let sut = await LocationsListViewModel(locationsRepository: mock)
        
        await sut.getAllLocations()
        
        #expect(sut.locations.isEmpty)
    }
    
    @Test("The new location is correctly created if all fields are valid")
    func testThatNewLocationIsCreatedCorrectlyIfFieldsAreValid() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let viewModel = await LocationsListViewModel(locationsRepository: mock)
                
        let sut = await viewModel.createNewLocation(name: "New York", latitude: "40.73", longitude: "-73.93")
        #expect(sut?.name == "New York")
        #expect(sut?.lat == 40.73)
        #expect(sut?.long == -73.93)
    }
    
    @Test("The new location is not created if fields are not valid")
    func testThatNewLocationIsNotCreatedIfFieldsAreNotValid() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let viewModel = await LocationsListViewModel(locationsRepository: mock)
                
        var sut = await viewModel.createNewLocation(name: "", latitude: "40.73", longitude: "-73.93")
        #expect(sut == nil)
        
        sut = await viewModel.createNewLocation(name: "New York", latitude: "abc", longitude: "-73.93")
        #expect(sut == nil)
        
        sut = await viewModel.createNewLocation(name: "New York", latitude: "40.73", longitude: "")
        #expect(sut == nil)
    }
    
    @Test("The new location is added to the locations list")
    func testThatNewLocationIsAddedToTheLocationsList() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let sut = await LocationsListViewModel(locationsRepository: mock)
        
        await sut.getAllLocations()
        
        if let location = await sut.createNewLocation(name: "New York", latitude: "40.73", longitude: "-73.93") {
            await sut.addLocation(location: location)
            
            #expect(sut.locations.count == 4)
            #expect(sut.locations[3].name == "New York")
            #expect(sut.locations[3].lat == 40.73)
            #expect(sut.locations[3].long == -73.93)
        }
    }
    
    @Test("The URL is created correctly with the coordinates")
    func testThatURLIsCreatedCorrectlyWithTheCoordinates() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let sut = await LocationsListViewModel(locationsRepository: mock)
                
        let url = await sut.createUrl(latitude: 12.3231, longitude: 9.8173)
        #expect(url?.absoluteString == "wikipedia://places?latitude=12.3231&longitude=9.8173")
    }
}
