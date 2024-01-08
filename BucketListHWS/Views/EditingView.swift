//
//  EditingView.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import SwiftUI

struct EditingView: View {
    var location: Location
    var onSaveAction: (Location) -> Void
    var onDeleteAction: (Location) -> Void
    
    @State private var name = ""
    @State private var desciption = ""
    @State private var loadingState: LoadingState<Pages> = .loading
    @State private var showAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    init(
        location: Location,
        onSave: @escaping (Location) -> Void,
        onDelete: @escaping (Location) -> Void
    ) {
        self.location = location
        self.onSaveAction = onSave
        self.onDeleteAction = onDelete
        
        _name = State(initialValue: location.name)
        _desciption = State(initialValue: location.description)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Location Details") {
                    TextField("Name:", text: $name)
                    TextField("Description:", text: $desciption)
                }
                
                Section {
                    Button(role: .destructive) {
                        showAlert = true
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                            .foregroundStyle(.red)
                    }
                    .buttonStyle(.borderless)
                }
                
                Section("Nearby...") {
                    switch loadingState {
                    case .loading:
                        ProgressView {
                            Text("Loading Interesting places for you!")
                        }
                    case .failed(let error):
                        ContentUnavailableView(
                            "Oops",
                            systemImage: "network.slash",
                            description: Text(error.localizedDescription)
                        )
                    case .loaded(let pages):
                        ForEach(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    }
                }
            }
            .navigationTitle("Place Details")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        var newLocation = self.location
                        newLocation.id = UUID()
                        newLocation.name = name
                        newLocation.description = desciption
                        
                        onSaveAction(newLocation)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss.callAsFunction()
                    }
                }
            }
            .alert("Are you sure you wanna delete \(location.name)?", isPresented: $showAlert) {
                Button("Confirm", role: .destructive) {
                    showAlert = false
                    onDeleteAction(location)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {
                    showAlert = false
                }
            } message: {
                Text("This will delete the location.")
            }
        }
        .task {
            self.loadingState = await Locations.fecthNearByPlaces(
                latitude: location.latitude,
                longitude: location.longitude
            )
        }
    }
}

#Preview {
    EditingView(location: .buckinghamPalace) { _ in
        
    } onDelete: { _ in
        
    }
}
