//
//  MainView.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import MapKit
import SwiftUI

struct MainView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            MapReader { proxy in
                Map {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red.gradient)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedLocation = location
                                }
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(coordinate.latitude, coordinate.longitude)
                    }
                }
            }
            .sheet(item: $viewModel.selectedLocation) { place in
                EditingView(location: place) { newLocation in
                    viewModel.updateLocation(location: newLocation)
                } onDelete: { loc in
                    viewModel.removeLocation(location: loc)
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
