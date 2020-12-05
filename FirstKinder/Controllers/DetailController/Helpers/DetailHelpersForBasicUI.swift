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
        
        //setDataToBarChart()
    }
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
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
        containerView.addSubview(childNumBoxView)
        childNumBoxView.widthAnchor.constraint(equalToConstant: view.frame.width / 3 - 10).isActive = true
        childNumBoxView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        childNumBoxView.topAnchor.constraint(equalTo: chart.bottomAnchor).isActive = true
        childNumBoxView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        imgView.contentMode = .center
        childNumBoxView.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: childNumBoxView.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: childNumBoxView.centerYAnchor).isActive = true
        imgView.contentMode = .scaleAspectFit
        
        setChildBoxByCurrentChildNum(imgView)
        
        childNumBoxView.addSubview(numOfChildLabel)
        numOfChildLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        numOfChildLabel.bottomAnchor.constraint(equalTo: childNumBoxView.bottomAnchor, constant: -5).isActive = true
        numOfChildLabel.widthAnchor.constraint(equalTo: childNumBoxView.widthAnchor).isActive = true
        numOfChildLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        numOfChildLabel.text = "정원 : \(kinder.currentNumOfChild) / \(kinder.totalNumOfChild)"
        
        
    }
    func drawNumOfTeacher() {
        containerView.addSubview(teacherNumBoxView)
        teacherNumBoxView.widthAnchor.constraint(equalToConstant: view.frame.width / 3 - 10).isActive = true
        teacherNumBoxView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        teacherNumBoxView.topAnchor.constraint(equalTo: chart.bottomAnchor).isActive = true
        teacherNumBoxView.leftAnchor.constraint(equalTo: childNumBoxView.rightAnchor, constant: 10).isActive = true
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.loadGif(name: "teacher")
        imgView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        teacherNumBoxView.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: teacherNumBoxView.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: teacherNumBoxView.centerYAnchor).isActive = true
        imgView.contentMode = .scaleAspectFit
        
        teacherNumBoxView.addSubview(numOfTeacherLabel)
        numOfTeacherLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        numOfTeacherLabel.bottomAnchor.constraint(equalTo: teacherNumBoxView.bottomAnchor, constant: -5).isActive = true
        numOfTeacherLabel.widthAnchor.constraint(equalTo: teacherNumBoxView.widthAnchor).isActive = true
        numOfTeacherLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        numOfTeacherLabel.text = "선생님: " + kinder.numOfTeachr + "명"
    }
    func drawCarAvailableLabel() {
        containerView.addSubview(busBoxView)
        busBoxView.widthAnchor.constraint(equalToConstant: view.frame.width / 3 - 10).isActive = true
        busBoxView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        busBoxView.topAnchor.constraint(equalTo: chart.bottomAnchor).isActive = true
        busBoxView.leftAnchor.constraint(equalTo: teacherNumBoxView.rightAnchor, constant: 10).isActive = true
        busBoxView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        busBoxView.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: busBoxView.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: busBoxView.centerYAnchor).isActive = true
        imgView.contentMode = .scaleAspectFit
        

        busBoxView.addSubview(carAvailableLabel)
        carAvailableLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        carAvailableLabel.bottomAnchor.constraint(equalTo: busBoxView.bottomAnchor, constant: -5).isActive = true
        carAvailableLabel.widthAnchor.constraint(equalTo: busBoxView.widthAnchor).isActive = true
        carAvailableLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        carAvailableLabel.text = kinder.isCarAvailable
        if kinder.isCarAvailable == "운영" {
            imgView.loadGif(name: "bus")
            carAvailableLabel.textColor = .systemGreen
        } else {
            imgView.loadGif(name: "nobus")
            carAvailableLabel.textColor = .systemRed
        }
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
        chart.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(chart)
        chart.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        chart.heightAnchor.constraint(equalToConstant: 250).isActive = true
        chart.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        setDataToPieChart(chart)
//        chart.xAxis.drawGridLinesEnabled = false
//        barChart.leftAxis.drawGridLinesEnabled = false
//        chart.xAxis.labelPosition = .bottom
//        chart.xAxis.drawLabelsEnabled = false
//        barChart.rightAxis.enabled = false
//        chart.isUserInteractionEnabled = false
    }
//    func setDataToBarChart() {
//        let childDataSet = BarChartDataEntry(x: 0, y: Double(kinder.currentNumOfChild)!)
//        let teacherDataSet = BarChartDataEntry(x: 0.6, y: Double(kinder.numOfTeachr)!)
//        var dataSets = [BarChartDataEntry]()
//
//        dataSets.append(childDataSet)
//        dataSets.append(teacherDataSet)
//
//        let set = BarChartDataSet(entries: dataSets, label: "아동 수 대 선생님 수")
//        set.colors = [.link, .systemPink]
//        let data = BarChartData(dataSet: set)
//        data.setDrawValues(false)
//        data.barWidth = 0.3
//        chart.data = data
//    }
    func setDataToPieChart(_ pieChart: PieChartView) {
        guard let currentChildNum = Double(kinder.currentNumOfChild) else { return }
        guard let teacherNum = Double(kinder.numOfTeachr) else { return }
        let currentChildDataSet = PieChartDataEntry(value: currentChildNum, label: "아동 수")
        let totalChildDataSet = PieChartDataEntry(value: teacherNum, label: "선생님 수")
        
        var dataSets = [PieChartDataEntry]()
        
        dataSets.append(currentChildDataSet)
        dataSets.append(totalChildDataSet)
        
        let set = PieChartDataSet(entries: dataSets, label: "")
        set.colors = [.systemBlue, .systemPink]
        let data = PieChartData(dataSet: set)
        data.setDrawValues(false)
        pieChart.data = data
    }
    func addPlusButtonOnNavBar() {
        if !isFromMyKinder {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handlePlusButtonTap))
        } else {
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .trash, target: self, action: #selector(handleTrashButtonTap))

        }
    }
    //총 수용 인원 중 현재 인원의 비율
    func setChildBoxByCurrentChildNum(_ imgView: UIImageView) {
        
        guard let currentChildNum = Double(kinder.currentNumOfChild) else { return }
        guard let totalChildNum = Double(kinder.totalNumOfChild) else { return }
        
        let capacityPercentage = (currentChildNum / totalChildNum) * 100
        
        if capacityPercentage <= 45 {
            numOfChildLabel.textColor = .systemGreen
            imgView.image = #imageLiteral(resourceName: "392001870_SMILING_FACE_WITH_HEARTS_STICKER_400")
            
        } else if capacityPercentage <= 75 {
            numOfChildLabel.textColor = .systemYellow
            imgView.loadGif(name: "thinkingFace")

        } else {
            numOfChildLabel.textColor = .systemRed
            imgView.loadGif(name: "thinkingFace")

        }
    }
}
