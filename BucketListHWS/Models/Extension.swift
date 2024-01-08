//
//  Extension.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import MapKit
import SwiftUI

extension Locations {
    private static func urlString(latitude: Double, longitude: Double) -> String {
        "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
    }
    
    static func fecthNearByPlaces(latitude: Double, longitude: Double) async -> LoadingState<Pages> {
        guard let url = URL(string: urlString(latitude: latitude, longitude: longitude)) else {
            return .failed(URLError(.badURL))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(Result.self, from: data)
            let pages = result.query.pages.values.sorted()
            
            return .loaded(pages)
        } catch {
            return .failed(error)
        }
    }
}

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
    
    static let brandenburgGate = Location(
        "Brandenburg Gate",
        description: "An 18th-century neoclassical monument in Berlin, built on the orders of the King of Prussia Frederick William II after restoring the Orangist power by suppressing the Dutch popular unrest.",
        longitude: 13.3777,
        latitude: 52.5163
    )
    
    static let nurburing = Location(
        "Nürburgring",
        description: "The Nürburgring is a 150,000 person capacity motorsports complex located in the town of Nürburg, Rhineland-Palatinate.",
        longitude: 6.9459,
        latitude: 50.3332
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
