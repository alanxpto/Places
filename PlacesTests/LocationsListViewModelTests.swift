import Testing
import Places

@Suite("Locations List View Model Tests")
struct LocationsListViewModelTests {
    @Test("The locations array is empty")
    func testLocationsListViewModelInitialState() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let sut = LocationsListViewModel(locationsRepository: mock)
        
        #expect(sut.locations.isEmpty)
    }
    
    @Test("The location list has the correct values if the API call is valid")
    func testThatLocationListHasCorrectValueWithValidAPICall() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let sut = LocationsListViewModel(locationsRepository: mock)
        
        try await sut.getAllLocations()
        
        #expect(sut.locations.count == 3)
        #expect(sut.locations[0].name == "Amsterdam")
        #expect(sut.locations[1].name == "Mumbai")
        #expect(sut.locations[2].name == "Copenhagen")
    }
    
    @Test("The location list is empty if the API call is invalid")
    func testThatLocationListIsEmptyWithInvalidAPICall() async throws {
        let mock = MockLocationRepository(shouldFail: true)
        let sut = LocationsListViewModel(locationsRepository: mock)
        
        do {
            try await sut.getAllLocations()
        } catch {
            #expect(sut.locations.isEmpty)
        }
    }
    
    @Test("The new location is correctly created if all fields are valid")
    func testThatNewLocationIsCreatedCorrectlyIfFieldsAreValid() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let viewModel = LocationsListViewModel(locationsRepository: mock)
                
        let sut = viewModel.createNewLocation(name: "New York", latitude: "40.73", longitude: "-73.93")
        #expect(sut?.name == "New York")
        #expect(sut?.lat == 40.73)
        #expect(sut?.long == -73.93)
    }
    
    @Test("The new location is not created if fields are not valid")
    func testThatNewLocationIsNotCreatedIfFieldsAreNotValid() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let viewModel = LocationsListViewModel(locationsRepository: mock)
                
        var sut = viewModel.createNewLocation(name: "", latitude: "40.73", longitude: "-73.93")
        #expect(sut == nil)
        
        sut = viewModel.createNewLocation(name: "New York", latitude: "abc", longitude: "-73.93")
        #expect(sut == nil)
        
        sut = viewModel.createNewLocation(name: "New York", latitude: "40.73", longitude: "")
        #expect(sut == nil)
    }
    
    @Test("The new location is added to the locations list")
    func testThatNewLocationIsAddedToTheLocationsList() async throws {
        let mock = MockLocationRepository(shouldFail: false)
        let sut = LocationsListViewModel(locationsRepository: mock)
        
        try await sut.getAllLocations()
        
        if let location = sut.createNewLocation(name: "New York", latitude: "40.73", longitude: "-73.93") {
            sut.addLocation(location: location)
            
            #expect(sut.locations.count == 4)
            #expect(sut.locations[3].name == "New York")
            #expect(sut.locations[3].lat == 40.73)
            #expect(sut.locations[3].long == -73.93)
        }
    }
}
