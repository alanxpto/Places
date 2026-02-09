import Testing

struct LocationRepositoryErrorTests {
    @Test("The error message is correct")
    func testThatErrorMessageIsCorrect() async throws {
        var message = LocationRepositoryError.decodingError.userMessage
        #expect(message == "Failed to read server response")
        
        message = LocationRepositoryError.invalidUrl.userMessage
        #expect(message == "Invalid URL")
        
        message = LocationRepositoryError.unknownError.userMessage
        #expect(message == "Something went wrong")
    }
}
