//
//  HelperForMap.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit
import MapKit

extension KinderDetailController {
    func setAnnotaion() {
        let annotation = MKPointAnnotation()
        guard let lo = Double(kinder.lo) else { return }
        guard let la = Double(kinder.la) else { return }
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: la, longitude: lo)
        annotation.coordinate = centerCoordinate
        annotation.title = kinder.title
        mapView.addAnnotation(annotation)
        mapView.setRegion(MKCoordinateRegion(center: centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)), animated: false)
    }
}
