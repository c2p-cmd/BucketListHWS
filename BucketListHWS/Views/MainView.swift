//
//  MainView.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import MapKit
import SwiftUI

struct MainView: View {
    @State private var locations: Locations = [
        .buckinghamPalace,
        .towerOfLondon
    ]
    
    var body: some View {
        VStack {
            MapReader { proxy in
                Map {
                    ForEach(locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red.gradient)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        addNew(coordinate)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func addNew(_ coordinate: CLLocationCoordinate2D) {
        let location = Location("New Location", description: "", longitude: coordinate.longitude, latitude: coordinate.latitude)
        
        locations.append(location)
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
