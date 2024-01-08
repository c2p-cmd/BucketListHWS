//
//  Models.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import MapKit

fileprivate func urlString(latitude: String, longitude: String) -> String {
    "https://en.wikipedia.org/w/api.php?ggscoord=\(latitude)%7C\(longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
}

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var longitude: Double
    var latitude: Double
    
    init(_ name: String, description: String, longitude: Double, latitude: Double) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.longitude = longitude
        self.latitude = latitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func==(lhs: Location, rhs: Location) -> Bool {
        lhs.longitude == rhs.longitude && lhs.latitude == rhs.longitude
    }
}

typealias Locations = [Location]
