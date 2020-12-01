//
//  DetailController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit
import MapKit

class DetailController: UIViewController, CLLocationManagerDelegate {
    var kinder = Kinder()
    var mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    override func viewDidLoad() {
        configureUI()
    }
    func configureUI() {
        view.backgroundColor = .white
        drawMap()
    }
    func drawMap() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
