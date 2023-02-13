//
//  MKMapView+Extension.swift
//  FloodAreas
//
//  Created by KaiNgo on 13/02/2023.
//

import Foundation
import MapKit

extension MKMapView {
    /// Focus Mapview in the whole New South Wales state when open.
    func setDefaultRegion() {
        let newSouthWalesCoor = CLLocationCoordinate2D(latitude: CLLocationDegrees(-31.64968), longitude: CLLocationDegrees(146.72697))
        let newSouthWalesRegion = MKCoordinateRegion(center: newSouthWalesCoor, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
        self.setRegion(newSouthWalesRegion, animated: true)
    }
    
    /// Set new coordinator.
    /// - Parameters:
    ///   - lat: lat. Float value.
    ///   - lon: lon. Float value.
    ///   - mainFeature: the Feature.
    func showCoordinateAt(lat: Float, lon: Float, mainFeature: Feature? = nil) {
        let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        
        let currentRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.setRegion(currentRegion, animated: true)
        
        let myFloodAnnotation = FloodAnnotation()
        myFloodAnnotation.myFeature = mainFeature //
        myFloodAnnotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        self.addAnnotation(myFloodAnnotation)
    }
}
