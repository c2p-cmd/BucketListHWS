//
//  Extension.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import MapKit
import SwiftUI

extension Location {
    static let buckinghamPalace = Location(
        "Buckingham Palace",
        description: "The Buckingham Palace",
        longitude: -0.141,
        latitude: 51.501
    )
    
    static let towerOfLondon = Location(
        "Tower Of London",
        description: "The Tower of London",
        longitude: -0.076,
        latitude: 51.508
    )
}

extension MapCameraPosition {
    static let london = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    static let paris = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
    
    static let tokyo = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    )
}
