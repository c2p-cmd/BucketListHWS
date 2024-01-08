//
//  Models.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import MapKit

// MARK: API Models
struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        terms?["description"]?.first ?? ""
    }
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.pageid < rhs.pageid
    }
}

// MARK: App Model
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
        lhs.id == rhs.id
    }
}

typealias Locations = [Location]

// MARK: View Enum
enum LoadingState<T: Codable> {
    case loading
    case failed(Error)
    case loaded(T)
}

typealias Pages = [Page]
