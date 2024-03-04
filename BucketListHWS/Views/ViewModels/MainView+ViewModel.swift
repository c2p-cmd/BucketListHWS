//
//  MainView+ViewModel.swift
//  BucketListHWS
//
//  Created by Sharan Thakur on 08/01/24.
//

import MapKit
import SwiftUI
import Observation

extension MainView {
    @Observable
    class ViewModel {
        var mapRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.1657, longitude: 10.4515),
            span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        )
        
        private(set) var locations: Locations = [
            .brandenburgGate,
            .nurburing
        ]
        
        var selectedLocation: Location?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlace")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode(Locations.self, from: data)
            } catch {
                locations = [
                    .brandenburgGate,
                    .nurburing
                ]
            }
        }
        
        private func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Cannot save file: \(error.localizedDescription)")
            }
        }
        
        func addLocation(_ latitude: Double, _ longitude: Double) {
            let newLocation = Location("New Location \(locations.count+1)", description: "", longitude: longitude, latitude: latitude)
            locations.append(newLocation)
            save()
            selectedLocation = newLocation
        }
        
        func updateLocation(location: Location) {
            guard let place = selectedLocation else { return }
            
            if let index = locations.firstIndex(of: place) {
                locations[index] = location
                save()
            }
        }
        
        func removeLocation(location: Location) {
            if let index = locations.firstIndex(of: location) {
                locations.remove(at: index)
                save()
            }
        }
    }
}
