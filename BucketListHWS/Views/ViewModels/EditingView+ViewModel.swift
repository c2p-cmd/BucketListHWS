//
//  EditingView+ViewModel.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 09/01/24.
//

import Observation
import SwiftUI

extension EditingView {
    @Observable
    class ViewModel {
        var location: Location
        public var name: String
        public var description: String
        
        init(location: Location) {
            self.location = location
            _name = location.name
            _description = location.description
        }
        
        func newLocation() -> Location {
            var newLocation = location
            newLocation.id = UUID()
            newLocation.name = name
            newLocation.description = description
            
            return newLocation
        }
        
        func fetchNearbyPlaces() async -> LoadingState<Pages> {
            await Locations.fecthNearByPlaces(
                latitude: location.latitude,
                longitude: location.longitude
            )
        }
    }
}
