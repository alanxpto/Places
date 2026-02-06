import SwiftUI

struct LocationsListView: View {
    @Environment(\.openURL) private var openURL
    
    @StateObject private var viewModel = LocationsListViewModel(locationsRepository: LocationsRepositoryAPI())
    
    @State private var selectedLocationID: UUID?
    @State private var showInputLocation = false
    @State private var showError = false
    
    var body: some View {
        VStack {
            headerSectionView()
                .padding(.horizontal, 16)
            
            listSectionView()
                .padding(.horizontal, 16)
            
            Spacer()
        }.task {
            await viewModel.getAllLocations()
            
            showError = viewModel.errorMessage != nil
        }
        .alert(viewModel.errorMessage ?? "", isPresented: $showError) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        }
        .sheet(isPresented: $showInputLocation) {
            InputLocationView(viewModel: viewModel)
        }
    }
    
    private func headerSectionView() -> some View {
        Group {
            Text("Places")
                .multilineTextAlignment(.center)
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color("abn_green"))
            
            Text("Select a location in the list or manually input a location to open the Wikipedia app and read articles about it")
                .multilineTextAlignment(.center)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(Color("abn_yellow"))
            
            Button {
                showInputLocation = true
            } label: {
                Text("Tap here to input manual location")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("abn_green"))
            }
            .padding(.top, 8)
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
                if let url = viewModel.createUrl(latitude: location.lat, longitude: location.long) {
                    openURL(url)
                }
                
                selectedLocationID = location.id
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationsListView()
}
