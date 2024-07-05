//
//  OtogeNaviMapView.swift
//  OtogeNavi
//
//  Created by Galvin Gao on 7/5/24.
//

import MapKit
import UIKit

class OtogeNaviMapView: MKMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 35.681236, longitude: 139.767125),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        setRegion(region, animated: true)
    }
}
