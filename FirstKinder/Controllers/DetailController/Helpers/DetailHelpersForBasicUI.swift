//
//  DetailHelpersForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit
import Charts
import GoogleMobileAds

extension DetailController: ChartViewDelegate {
    func configureUI() {
        view.backgroundColor = .white
        addPlusButtonOnNavBar()
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
        drawChart()
        
        setDataToChart()
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
        
        setChildNumLabelColor()
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
        telLabel.textColor = .link
        telLabel.text = "📞 " + kinder.tel
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTelTap))
        telLabel.addGestureRecognizer(tapGesture)
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
        
        //시뮬레이터에서 테스트 할 때
        sizeOfRoomLabel.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
        //실제 기기에서 테스트 할 때
        //sizeOfRoomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        sizeOfRoomLabel.text = "보육실 면적: " + kinder.sizeOfRoom + "m²"
    }
    func drawChart() {
        barChart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(barChart)
        barChart.widthAnchor.constraint(equalToConstant: 200).isActive = true
        barChart.heightAnchor.constraint(equalToConstant: 150).isActive = true
        barChart.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        barChart.topAnchor.constraint(equalTo: detailAddressTextView.bottomAnchor).isActive = true
        
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.drawLabelsEnabled = false
        barChart.rightAxis.enabled = false
        barChart.isUserInteractionEnabled = false
    }
    func setDataToChart() {
        let childDataSet = BarChartDataEntry(x: 0, y: Double(kinder.currentNumOfChild)!)
        let teacherDataSet = BarChartDataEntry(x: 0.6, y: Double(kinder.numOfTeachr)!)
        var dataSets = [BarChartDataEntry]()
        
        dataSets.append(childDataSet)
        dataSets.append(teacherDataSet)
        
        let set = BarChartDataSet(entries: dataSets, label: "아동 수 대 선생님 수")
        set.colors = [.link, .systemPink]
        let data = BarChartData(dataSet: set)
        data.setDrawValues(false)
        data.barWidth = 0.3
        barChart.data = data
    }
    func addPlusButtonOnNavBar() {
        if !isFromMyKinder {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handlePlusButtonTap))
        } else {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .trash, target: self, action: #selector(handleTrashButtonTap))

        }
    }
    func addBannerView(_ bannerView: GADBannerView) {
        
        bannerView.adUnitID = "ca-app-pub-9114448172368235/7500496163"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        bannerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    //총 수용 인원 중 현재 인원의 비율
    func setChildNumLabelColor() {
        
        guard let currentChildNum = Double(kinder.currentNumOfChild) else { return }
        guard let totalChildNum = Double(kinder.totalNumOfChild) else { return }
        
        let capacityPercentage = (currentChildNum / totalChildNum) * 100
        
        if capacityPercentage <= 45 {
            numOfChildLabel.textColor = .systemGreen
        } else if capacityPercentage <= 75 {
            numOfChildLabel.textColor = .systemYellow
        } else {
            numOfChildLabel.textColor = .systemRed
        }
    }
}
