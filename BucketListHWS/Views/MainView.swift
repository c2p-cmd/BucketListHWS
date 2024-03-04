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
    @AppStorage("standard_map") private var standardMap = false
    @State private var scalingLocation: Location?
    
    var body: some View {
        MapReader { (proxy: MapProxy) in
            Map {
                ForEach(viewModel.locations) { (location: Location) in
                    let scaleUp = scalingLocation == location
                    
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red.gradient)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .animation(.snappy) { content in
                                content.scaleEffect(scaleUp ? 1.3 : 1, anchor: .bottom)
                            }
                            .onLongPressGesture(minimumDuration: 0.75) {
                                viewModel.selectedLocation = location
                            } onPressingChanged: { (pressed: Bool) in
                                scalingLocation = pressed ? location : nil
                            }
                    }
                }
            }
            .mapStyle(standardMap ? .standard : .hybrid(elevation: .realistic))
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
        .overlay(alignment: .topLeading) {
            Button {
                standardMap.toggle()
            } label: {
                Label("", systemImage: !standardMap ? "map.fill" : "view.3d")
                    .labelStyle(.iconOnly)
            }
            .background(.thinMaterial)
            .buttonStyle(.bordered)
            .padding(.leading)
            .padding(.top)
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
            .preferredColorScheme(.dark)
    }
}
