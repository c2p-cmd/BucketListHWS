//
//  EditingView.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import SwiftUI

struct EditingView: View {
    var onSaveAction: (Location) -> Void
    var onDeleteAction: (Location) -> Void
    
    @State private var viewModel: ViewModel
    @State private var loadingState: LoadingState<Pages> = .loading
    @State private var showAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    init(
        location: Location,
        onSave: @escaping (Location) -> Void,
        onDelete: @escaping (Location) -> Void
    ) {
        self.onSaveAction = onSave
        self.onDeleteAction = onDelete
        
        _viewModel = State(initialValue: ViewModel(location: location))
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Location Details") {
                    TextField("Name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description, axis: .vertical)
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
                        let newLocation = viewModel.newLocation()
                        
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
            .alert("Are you sure you wanna delete \(viewModel.location.name)?", isPresented: $showAlert) {
                Button("Confirm", role: .destructive) {
                    showAlert = false
                    onDeleteAction(viewModel.location)
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
            self.loadingState = await viewModel.fetchNearbyPlaces()
        }
    }
}

#Preview {
    EditingView(location: .buckinghamPalace) { _ in
        
    } onDelete: { _ in
        
    }
}
