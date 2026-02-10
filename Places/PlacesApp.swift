import SwiftUI

@main
struct PlacesApp: App {
    var body: some Scene {
        WindowGroup {
            LocationsListView(
                viewModel: LocationsListViewModel(
                    locationsRepository: RemoteLocationsRepository()
                )
            )
        }
    }
}
