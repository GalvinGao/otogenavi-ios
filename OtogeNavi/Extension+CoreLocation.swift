//
//  Extension+UUID.swift
//  OtogeNavi
//
//  Created by Galvin Gao on 5/29/24.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    func extend(by factor: Double) -> MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: span.latitudeDelta * factor, longitudeDelta: span.longitudeDelta * factor)
        return MKCoordinateRegion(center: center, span: span)
    }
}

public extension CLLocationCoordinate2D {
    func distance(to other: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1 = CLLocation(latitude: latitude, longitude: longitude)
        let location2 = CLLocation(latitude: other.latitude, longitude: other.longitude)
        return location1.distance(from: location2)
    }
}
