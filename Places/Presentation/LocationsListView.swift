import SwiftUI

struct LocationsListView: View {
    private let locations: [Location]
    
    init() {
        locations = [
            .init(name: "Amsterdam", lat: 12.45, long: 15.14),
            .init(name: "Dubai", lat: 13.319, long: 9.31),
            .init(name: "Rio", lat: 4.481, long: 7.3),
        ]
    }
    
    var body: some View {
        VStack {
            headerSectionView()
                .padding(.horizontal, 16)
            
            listSectionView()
            
            Spacer()
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
        List(locations) { location in
            VStack(alignment: .leading) {
                Text(location.name ?? "- -")
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

#Preview {
    LocationsListView()
}
