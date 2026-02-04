import SwiftUI

struct InputLocationView: View {
    private let viewModel = InputLocationViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var inputLocationName = ""
    @State private var inputLocationLatitude = ""
    @State private var inputLocationLongitude = ""
    
    var newLocation: Location?
    
    var body: some View {
        VStack {
            headerSectionView()
            
            inputFieldsSectionView()
            
            buttonsSectionView()
        }
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
            TextField("Type the location name here", text: $inputLocationName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 8)
            
            TextField("Type the location latitude here", text: $inputLocationLatitude)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 8)
            
            TextField("Type the location longitude here", text: $inputLocationLongitude)
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
                    print("User typed: \(inputLocationName)")
                    print("User typed: \(inputLocationLatitude)")
                    print("User typed: \(inputLocationLongitude)")
                    
                    dismiss()
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    InputLocationView()
}
