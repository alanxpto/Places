import SwiftUI

struct InputLocationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var inputLocationName = ""
    @State private var inputLocationLatitude = ""
    @State private var inputLocationLongitude = ""
    
    @State private var showError = false
    
    @ObservedObject var viewModel: LocationsListViewModel
    
    var body: some View {
        VStack {
            headerSectionView()
            
            inputFieldsSectionView()
            
            buttonsSectionView()
        }.alert("Attention", isPresented: $showError, actions: {
            Button("OK", role: .cancel) {
                showError = false
            }
        }, message: {
            Text("One or more location fields are invalid. Please check and try again.")
        })
    }
    
    private func headerSectionView() -> some View {
        Text("Enter the location details")
            .multilineTextAlignment(.center)
            .font(.title)
            .fontWeight(.medium)
            .foregroundStyle(Color("abn_yellow"))
    }
    
    private func inputFieldsSectionView() -> some View {
        Group {
            TextField("Type the name here", text: $inputLocationName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 8)
            
            TextField("Type the latitude here", text: $inputLocationLatitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 8)
            
            TextField("Type the longitude here", text: $inputLocationLongitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 8)
        }
    }
    
    private func buttonsSectionView() -> some View {
        HStack {
            Spacer()
            
            Button("Cancel") {
                dismiss()
                
                inputLocationName = ""
                inputLocationLatitude = ""
                inputLocationLongitude = ""
            }
            
            Button("Confirm") {
                if let location = viewModel.createNewLocation(name: inputLocationName, latitude: inputLocationLatitude, longitude: inputLocationLongitude) {
                    
                    viewModel.addLocation(location: location)
                    
                    dismiss()
                } else {
                    showError = true
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    InputLocationView(viewModel: LocationsListViewModel(locationsRepository: LocationsRepositoryAPI()))
}
