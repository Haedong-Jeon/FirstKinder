//
//  NearKinderController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit
import MapKit
import CoreLocation

class NearKinderController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    let locationManager = CLLocationManager() // location manager
    var currentLocation: CLLocation! // 내 위치 저장
    
    override func viewDidLoad() {
        self.mapView.delegate = self
        configureUI()
        checkLocationService()
    }
    func configureUI() {
        self.navigationController?.navigationBar.topItem?.title = "근처 어린이집"
        view.backgroundColor = .white
        
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
    }
    func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            let locationServiceOffAlert = UIAlertController(title: "위치 서비스", message: "위치 서비스가 꺼져있습니다.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
                //확인 버튼 눌렀을 때 뭘 할진 나중에 생각하자.
            }
            locationServiceOffAlert.addAction(okButton)
            self.present(locationServiceOffAlert, animated: false, completion: nil)
        }
    }
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            kinders.forEach({setAnnotaion(kinder: $0)})
            break
        @unknown default:
            break
        }
    }
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func setAnnotaion(kinder: Kinder) {
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

extension NearKinderController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
