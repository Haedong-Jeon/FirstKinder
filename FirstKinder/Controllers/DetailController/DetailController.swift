//
//  DetailController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit
import MapKit

class DetailController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var kinder = Kinder()
    var mapView: MKMapView = {
        var mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    var kinderTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.init(name: "CookieRun", size: 20)
        return label
    }()
    var numOfChildLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var carAvailableLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var telLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var numOfTeacherLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var numOfRoomLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var sizeOfRoomLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var detailAddressTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    override func viewDidLoad() {
        configureUI()
    }
    func configureUI() {
        view.backgroundColor = .white
        drawMap()
        setAnnotaion()
        drawKinderTitle()
        drawAddress()
        drawNumOfChild()
        drawNumOfTeacher()
        drawCarAvailableLabel()
        drawTel()
        drawRoomCount()
        drawRoomSize()
    }
    func drawMap() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    func drawKinderTitle() {
        view.addSubview(kinderTitleLabel)
        kinderTitleLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        kinderTitleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        kinderTitleLabel.text = kinder.title
    }
    func drawNumOfChild() {
        view.addSubview(numOfChildLabel)
        numOfChildLabel.topAnchor.constraint(equalTo: detailAddressTextView.bottomAnchor).isActive = true
        numOfChildLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        numOfChildLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numOfChildLabel.text = "정원 : \(kinder.currentNumOfChild) / \(kinder.totalNumOfChild)"
    }
    func drawNumOfTeacher() {
        view.addSubview(numOfTeacherLabel)
        numOfTeacherLabel.topAnchor.constraint(equalTo: numOfChildLabel.bottomAnchor).isActive = true
        numOfTeacherLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        numOfTeacherLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numOfTeacherLabel.text = "선생님: " + kinder.numOfTeachr + "명"
    }
    func drawCarAvailableLabel() {
        view.addSubview(carAvailableLabel)
        carAvailableLabel.topAnchor.constraint(equalTo: numOfTeacherLabel.bottomAnchor).isActive = true
        carAvailableLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        carAvailableLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        carAvailableLabel.text = "🚌 " + kinder.isCarAvailable
    }
    func drawAddress() {
        view.addSubview(detailAddressTextView)
        detailAddressTextView.topAnchor.constraint(equalTo: kinderTitleLabel.bottomAnchor).isActive = true
        detailAddressTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        detailAddressTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        detailAddressTextView.text = kinder.craddr
    }
    func drawTel() {
        view.addSubview(telLabel)
        telLabel.topAnchor.constraint(equalTo: carAvailableLabel.bottomAnchor).isActive = true
        telLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        telLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        telLabel.text = "📞 " + kinder.tel
    }
    func drawRoomCount() {
        view.addSubview(numOfRoomLabel)
        numOfRoomLabel.topAnchor.constraint(equalTo: telLabel.bottomAnchor).isActive = true
        numOfRoomLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        numOfRoomLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numOfRoomLabel.text = "보육실 수: " + kinder.numOfRoom
    }
    func drawRoomSize() {
        view.addSubview(sizeOfRoomLabel)
        sizeOfRoomLabel.topAnchor.constraint(equalTo: numOfRoomLabel.bottomAnchor).isActive = true
        sizeOfRoomLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        sizeOfRoomLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sizeOfRoomLabel.text = "보육실 면적: " + kinder.sizeOfRoom + "m²"
    }
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

