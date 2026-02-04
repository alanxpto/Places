import SwiftUI

struct LocationsListView: View {
    @StateObject private var viewModel = LocationsListViewModel(locationsRepository: LocationsRepositoryAPI())
    
    var body: some View {
        VStack {
            headerSectionView()
                .padding(.horizontal, 16)
            
            listSectionView()
            
            Spacer()
        }.task {
            await viewModel.getAllLocations()
        }
    }
    
    private func headerSectionView() -> some View {
        Group {
            Text("Places")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.bold)
            
            Text("Tap a location to open the Wikipedia app and read articles about it")
                .multilineTextAlignment(.center)
                .font(.headline)
                .fontWeight(.medium)
        }
    }
    
    private func listSectionView() -> some View {
        List(viewModel.locations) { location in
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title)
                
                Text("Latitude: \(location.lat)")
                    .font(.callout)
                
                Text("Longitude: \(location.long)")
                    .font(.callout)
            }
        }
        .listStyle(PlainListStyle())
    }
}

//#Preview {
//    LocationsListView()
//}
