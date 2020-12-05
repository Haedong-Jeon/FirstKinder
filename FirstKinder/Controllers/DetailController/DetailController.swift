//
//  DetailController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit
import MapKit
import Charts

class DetailController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    var kinder = Kinder()
    var isFromMyKinder = false
    lazy var barChart: BarChartView = {
        let chartView = BarChartView()
        return chartView
    }()
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
        label.isUserInteractionEnabled = true
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
        
        myKinders.forEach({
            if $0.title == self.kinder.title && $0.craddr == self.kinder.craddr && $0.tel == self.kinder.tel {
                isFromMyKinder = true
            }
        })
        configureUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIView.setAnimationsEnabled(false)
    }
}

