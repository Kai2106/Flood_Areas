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
}
