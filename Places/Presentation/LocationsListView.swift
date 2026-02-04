import SwiftUI

struct LocationsListView: View {
    @StateObject private var viewModel = LocationsListViewModel(locationsRepository: LocationsRepositoryAPI())
    @State private var selectedLocationID: UUID?
    
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
                .foregroundStyle(Color("abn_green"))
            
            Text("Tap a location to open the Wikipedia app and read articles about it")
                .multilineTextAlignment(.center)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(Color("abn_yellow"))
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
            .frame(maxWidth: .infinity, alignment: .leading)
            .cornerRadius(8)
            .contentShape(Rectangle())
            .listRowBackground(
                selectedLocationID == location.id ? Color("abn_green").opacity(0.3) : Color.clear
            )
            .onTapGesture {
                selectedLocationID = location.id
            }
        }
        .listStyle(PlainListStyle())
    }
}

//#Preview {
//    LocationsListView()
//}
