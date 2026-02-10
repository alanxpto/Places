import SwiftUI

struct LocationsListView: View {
    @Environment(\.openURL) private var openURL

    @StateObject private var viewModel: LocationsListViewModel

    @State private var selectedLocationID: UUID?
    @State private var showInputLocation = false
    
    init(viewModel: LocationsListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            contentView()
            
            if viewModel.isLoading {
                loadingView()
            }
        }
        .task {
            await viewModel.getAllLocations()
        }
        .alert(viewModel.errorMessage ?? "", isPresented: $viewModel.showError) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        }
        .sheet(isPresented: $showInputLocation) {
            InputLocationView(viewModel: viewModel)
        }
    }
    
    private func contentView() -> some View {
        VStack {
            headerSectionView()
                .padding(.horizontal, 16)
            
            listSectionView()
                .padding(.horizontal, 16)
            
            Spacer()
        }
    }
    
    private func loadingView() -> some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                ProgressView()
                
                Text("Loading...")
            }
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
            .contentShape(Rectangle())
            .listRowBackground(
                selectedLocationID == location.id ? Color("abn_green").opacity(0.3) : Color.clear
            )
            .onTapGesture {
                viewModel.didSelect(location: location) { url in
                    openURL(url)
                }
                
                selectedLocationID = location.id
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationsListView(viewModel: LocationsListViewModel(locationsRepository: MockLocationRepository(shouldFail: false)))
}
