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
        setScrollView()
        drawKinderTitle()
        drawAddress()
        drawMap()
        drawChart()
        addPlusButtonOnNavBar()
        setAnnotaion()
        drawNumOfChild()
        drawNumOfTeacher()
        drawCarAvailableLabel()
        drawTel()
        drawRoomCount()
        drawRoomSize()
        
        setDataToChart()
    }
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true

        
    }
    func drawMap() {
        containerView.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: detailAddressTextView.bottomAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mapView.layer.borderWidth = 2
        mapView.layer.borderColor = #colorLiteral(red: 0.1889419258, green: 0.1871659458, blue: 0.2520412803, alpha: 1)
    }
    func drawKinderTitle() {
        containerView.addSubview(kinderTitleLabel)
        kinderTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        kinderTitleLabel.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderTitleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        kinderTitleLabel.text = kinder.title
    }
    func drawNumOfChild() {
        containerView.addSubview(numOfChildLabel)
        numOfChildLabel.topAnchor.constraint(equalTo: barChart.bottomAnchor).isActive = true
        numOfChildLabel.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        numOfChildLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numOfChildLabel.text = "정원 : \(kinder.currentNumOfChild) / \(kinder.totalNumOfChild)"
        
        setChildNumLabelColor()
    }
    func drawNumOfTeacher() {
        containerView.addSubview(numOfTeacherLabel)
        numOfTeacherLabel.topAnchor.constraint(equalTo: numOfChildLabel.bottomAnchor).isActive = true
        numOfTeacherLabel.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        numOfTeacherLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numOfTeacherLabel.text = "선생님: " + kinder.numOfTeachr + "명"
    }
    func drawCarAvailableLabel() {
        containerView.addSubview(carAvailableLabel)
        carAvailableLabel.topAnchor.constraint(equalTo: numOfTeacherLabel.bottomAnchor).isActive = true
        carAvailableLabel.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        carAvailableLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        carAvailableLabel.text = "🚌 " + kinder.isCarAvailable
    }
    func drawAddress() {
        containerView.addSubview(detailAddressTextView)
        detailAddressTextView.topAnchor.constraint(equalTo: kinderTitleLabel.bottomAnchor).isActive = true
        detailAddressTextView.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        detailAddressTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        detailAddressTextView.text = kinder.craddr
    }
    func drawTel() {
        containerView.addSubview(telLabel)
        telLabel.topAnchor.constraint(equalTo: carAvailableLabel.bottomAnchor).isActive = true
        telLabel.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        telLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        telLabel.textColor = .link
        telLabel.text = "📞 " + kinder.tel
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTelTap))
        telLabel.addGestureRecognizer(tapGesture)
    }
    func drawRoomCount() {
        containerView.addSubview(numOfRoomLabel)
        numOfRoomLabel.topAnchor.constraint(equalTo: telLabel.bottomAnchor).isActive = true
        numOfRoomLabel.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        numOfRoomLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numOfRoomLabel.text = "보육실 수: " + kinder.numOfRoom
    }
    func drawRoomSize() {
        containerView.addSubview(sizeOfRoomLabel)
        sizeOfRoomLabel.topAnchor.constraint(equalTo: numOfRoomLabel.bottomAnchor).isActive = true
        sizeOfRoomLabel.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor).isActive = true
        sizeOfRoomLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //sizeOfRoomLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        sizeOfRoomLabel.text = "보육실 면적: " + kinder.sizeOfRoom + "m²"
    }
    func drawChart() {
        barChart.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(barChart)
        barChart.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        barChart.heightAnchor.constraint(equalToConstant: 150).isActive = true
        barChart.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        
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
