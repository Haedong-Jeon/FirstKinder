//
//  DetailHelpersForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit
import Charts

extension KinderDetailController: ChartViewDelegate {
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        setScrollView()
        drawKinderTitle()
        drawAddress()
        drawMap()
        drawChart()
        addLikeButtonOnNavBar()
        setAnnotaion()
        drawNumOfChild()
        drawNumOfTeacher()
        drawCarAvailableLabel()
        drawRoomCount()
        drawRoomSize()
        drawTel()
        drawWeb()
    }
    func setScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        scrollView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: view.frame.height + 200).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    func drawMap() {
        containerView.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: detailAddressTextView.bottomAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        mapView.layer.borderWidth = 2
        mapView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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
        
        let childLabel = UILabel()
        childLabel.translatesAutoresizingMaskIntoConstraints = false
        childLabel.font = UIFont.init(name: "CookieRun", size: 20)
        childLabel.text = kinder.currentNumOfChild
        
        childNumBoxView.addSubview(childLabel)
        childLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor).isActive = true
        childLabel.topAnchor.constraint(equalTo: imgView.topAnchor).isActive = true
        childLabel.rightAnchor.constraint(equalTo: childNumBoxView.rightAnchor, constant: 5).isActive = true
        childLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true


        setChildBoxByCurrentChildNum(imgView, childLabel)
        
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
        imgView.image = #imageLiteral(resourceName: "teacher")
        imgView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .black
        
        teacherNumBoxView.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: teacherNumBoxView.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: teacherNumBoxView.centerYAnchor).isActive = true
        
        let teacherNumLabel = UILabel()
        teacherNumLabel.translatesAutoresizingMaskIntoConstraints = false
        teacherNumLabel.font = UIFont.init(name: "CookieRun", size: 20)
        teacherNumLabel.text = kinder.numOfTeachr
        
        teacherNumBoxView.addSubview(teacherNumLabel)
        teacherNumLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor).isActive = true
        teacherNumLabel.topAnchor.constraint(equalTo: imgView.topAnchor).isActive = true
        teacherNumLabel.rightAnchor.constraint(equalTo: teacherNumBoxView.rightAnchor, constant: 5).isActive = true
        teacherNumLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
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
        imgView.contentMode = .scaleAspectFit
        
        busBoxView.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: busBoxView.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: busBoxView.centerYAnchor).isActive = true
        
        let carLabel = UILabel()
        carLabel.translatesAutoresizingMaskIntoConstraints = false
        carLabel.font = UIFont.init(name: "CookieRun", size: 20)
        
        busBoxView.addSubview(carLabel)
        carLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor).isActive = true
        carLabel.topAnchor.constraint(equalTo: imgView.topAnchor).isActive = true
        carLabel.rightAnchor.constraint(equalTo: busBoxView.rightAnchor, constant: 5).isActive = true
        carLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true

        
        busBoxView.addSubview(carAvailableLabel)
        carAvailableLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        carAvailableLabel.bottomAnchor.constraint(equalTo: busBoxView.bottomAnchor, constant: -5).isActive = true
        carAvailableLabel.widthAnchor.constraint(equalTo: busBoxView.widthAnchor).isActive = true
        carAvailableLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        carAvailableLabel.text = kinder.isCarAvailable
        if kinder.isCarAvailable == "운영" {
            imgView.image = #imageLiteral(resourceName: "car")
            imgView.tintColor = .black
            carAvailableLabel.textColor = .systemGreen
            carLabel.text = "YES"
            carLabel.textColor = .systemGreen
        } else {
            imgView.image = #imageLiteral(resourceName: "car")
            imgView.tintColor = .lightGray
            carAvailableLabel.textColor = .systemRed
            carLabel.text = "NO"
            carLabel.textColor = .systemRed
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
        let telTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTelTap))
        telBoxView.addGestureRecognizer(telTapGesture)
        
        containerView.addSubview(telBoxView)
        telBoxView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        telBoxView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        telBoxView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        telBoxView.topAnchor.constraint(equalTo: roomSizeBoxView.bottomAnchor, constant: 10).isActive = true
        
        telBoxView.addSubview(telLabel)
        telLabel.centerXAnchor.constraint(equalTo: telBoxView.centerXAnchor).isActive = true
        telLabel.centerYAnchor.constraint(equalTo: telBoxView.centerYAnchor).isActive = true
        telLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        telLabel.textColor = .link
        telLabel.text = "📞 " + kinder.tel
    }
    func drawWeb() {
        
        containerView.addSubview(webBoxView)
        webBoxView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        webBoxView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        webBoxView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -10).isActive = true
        webBoxView.topAnchor.constraint(equalTo: telBoxView.bottomAnchor, constant: 10).isActive = true
        
        webBoxView.addSubview(webButton)
        webButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        webButton.widthAnchor.constraint(equalTo: webBoxView.widthAnchor).isActive = true
        webButton.centerXAnchor.constraint(equalTo: webBoxView.centerXAnchor).isActive = true
        webButton.centerYAnchor.constraint(equalTo: webBoxView.centerYAnchor).isActive = true
        if kinder.web == "" {
            webButton.isUserInteractionEnabled = false
            webButton.setTitleColor(.gray, for: .normal)
        } else {
            webButton.isUserInteractionEnabled = true
            webButton.setTitleColor(.link, for: .normal)
        }
        webButton.setTitle("홈페이지 방문", for: .normal)
        webButton.addTarget(self, action: #selector(handleWebTap), for: .touchUpInside)
        webBoxView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
    }
    func drawRoomCount() {
        containerView.addSubview(roomCountBoxView)
        roomCountBoxView.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 10).isActive = true
        roomCountBoxView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        roomCountBoxView.topAnchor.constraint(equalTo: childNumBoxView.bottomAnchor, constant: 10).isActive = true
        roomCountBoxView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        roomCountBoxView.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: roomCountBoxView.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: roomCountBoxView.centerYAnchor).isActive = true
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "kindergarten")
        imgView.tintColor = .black
        
        let roomNumLabel = UILabel()
        roomNumLabel.translatesAutoresizingMaskIntoConstraints = false
        roomNumLabel.font = UIFont.init(name: "CookieRun", size: 20)
        roomNumLabel.text = kinder.numOfRoom
        
        roomCountBoxView.addSubview(roomNumLabel)
        roomNumLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor).isActive = true
        roomNumLabel.topAnchor.constraint(equalTo: imgView.topAnchor).isActive = true
        roomNumLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        roomCountBoxView.addSubview(numOfRoomLabel)
        numOfRoomLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        numOfRoomLabel.bottomAnchor.constraint(equalTo: roomCountBoxView.bottomAnchor).isActive = true
        numOfRoomLabel.widthAnchor.constraint(equalTo: roomCountBoxView.widthAnchor).isActive = true
        numOfRoomLabel.textAlignment = .center
        numOfRoomLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        numOfRoomLabel.text = "보육실 수: " + kinder.numOfRoom
    }
    func drawRoomSize() {
        containerView.addSubview(roomSizeBoxView)
        roomSizeBoxView.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 10).isActive = true
        roomSizeBoxView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        roomSizeBoxView.topAnchor.constraint(equalTo: childNumBoxView.bottomAnchor, constant: 10).isActive = true
        roomSizeBoxView.leftAnchor.constraint(equalTo: roomCountBoxView.rightAnchor, constant: 10).isActive = true
        roomSizeBoxView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant:  -10).isActive = true
        
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        roomSizeBoxView.addSubview(imgView)
        imgView.centerXAnchor.constraint(equalTo: roomSizeBoxView.centerXAnchor).isActive = true
        imgView.centerYAnchor.constraint(equalTo: roomSizeBoxView.centerYAnchor).isActive = true
        imgView.contentMode = .scaleAspectFit
        imgView.image = #imageLiteral(resourceName: "plans")
        imgView.tintColor = .black
        
        let roomSizeLabel = UILabel()
        roomSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        roomSizeLabel.font = UIFont.init(name: "CookieRun", size: 20)
        roomSizeLabel.text = kinder.sizeOfRoom
        
        roomSizeBoxView.addSubview(roomSizeLabel)
        roomSizeLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor).isActive = true
        roomSizeLabel.topAnchor.constraint(equalTo: imgView.topAnchor).isActive = true
        roomSizeLabel.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        roomSizeBoxView.addSubview(sizeOfRoomLabel)
        sizeOfRoomLabel.bottomAnchor.constraint(equalTo: roomSizeBoxView.bottomAnchor).isActive = true
        sizeOfRoomLabel.widthAnchor.constraint(equalTo: roomSizeBoxView.widthAnchor).isActive = true
        sizeOfRoomLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sizeOfRoomLabel.textAlignment = .center
        sizeOfRoomLabel.text = "보육실 면적: " + kinder.sizeOfRoom + "m²"
    }
    func drawChart() {
        chart.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(chart)
        chart.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        chart.heightAnchor.constraint(equalToConstant: 250).isActive = true
        chart.topAnchor.constraint(equalTo: mapView.bottomAnchor).isActive = true
        setDataToPieChart(chart)
    }

    func setDataToPieChart(_ pieChart: PieChartView) {
        guard let currentChildNum = Double(kinder.currentNumOfChild) else { return }
        guard let teacherNum = Double(kinder.numOfTeachr) else { return }
        let currentChildDataSet = PieChartDataEntry(value: currentChildNum, label: "아동 수: \(Int(currentChildNum))")
        let totalChildDataSet = PieChartDataEntry(value: teacherNum, label: "선생님 수: \(Int(teacherNum))")
        
        var dataSets = [PieChartDataEntry]()
        
        dataSets.append(currentChildDataSet)
        dataSets.append(totalChildDataSet)
        
        let set = PieChartDataSet(entries: dataSets, label: "")
        set.colors = [.systemBlue, .systemPink]
        let data = PieChartData(dataSet: set)
        data.setDrawValues(false)
        pieChart.data = data
    }
    func addLikeButtonOnNavBar() {
        if !isFromMyKinder {
            let heartButton = UIBarButtonItem(image: #imageLiteral(resourceName: "like"), style: .plain, target: self, action: #selector(handleHeartButtonTap))
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = heartButton
        } else {
            let trashButton = UIBarButtonItem(image: #imageLiteral(resourceName: "delete"), style: .plain, target: self, action: #selector(handleTrashButtonTap))
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem = trashButton
        }
    }
    //총 수용 인원 중 현재 인원의 비율
    func setChildBoxByCurrentChildNum(_ imgView: UIImageView, _ label: UILabel) {
        
        imgView.image = #imageLiteral(resourceName: "playtime")
        guard let currentChildNum = Double(kinder.currentNumOfChild) else { return }
        guard let totalChildNum = Double(kinder.totalNumOfChild) else { return }
        
        let capacityPercentage = (currentChildNum / totalChildNum) * 100
        
        if capacityPercentage <= 45 {
            numOfChildLabel.textColor = .systemGreen
            imgView.tintColor = .systemGreen
            label.textColor = .systemGreen
            
        } else if capacityPercentage <= 75 {
            numOfChildLabel.textColor = .systemYellow
            imgView.tintColor = .systemYellow
            label.textColor = .systemYellow
        } else {
            numOfChildLabel.textColor = .systemRed
            imgView.tintColor = .systemRed
            label.textColor = .systemRed
        }
    }
}
