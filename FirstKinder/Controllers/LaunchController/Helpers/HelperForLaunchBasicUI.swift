//
//  HelperForLaunchBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import SwiftGifOrigin

extension LaunchController {
    func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.5617534518, green: 0.5250410438, blue: 0.8910874724, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        drawTitleImg()
        drawTitleTextView()
        drawDataSource()
        drawHearts()
        drawIndicator()
    }
    func drawTitleTextView() {
        view.addSubview(titleLabel)
        titleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: titleImgView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.text = "퍼스트 킨더"
    }
    func drawTitleImg() {
        view.addSubview(titleImgView)
        titleImgView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleImgView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -30).isActive = true
        titleImgView.image = UIImage(systemName: "smiley")
        titleImgView.tintColor = .white
    }
    func drawDataSource() {
        view.addSubview(dataSourceLabel)
        dataSourceLabel.topAnchor.constraint(equalTo: titleImgView.bottomAnchor).isActive = true
        dataSourceLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        dataSourceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dataSourceLabel.text = "데이터 출처는 ⟪보육정보공개 API⟫입니다."
    }
    func drawHearts() {
        view.addSubview(heartImgView)
        view.addSubview(heartImgView2)
        
        heartImgView.loadGif(name: "heart")
        heartImgView2.loadGif(name: "heart")
        
        heartImgView.topAnchor.constraint(equalTo: titleImgView.topAnchor).isActive = true
        heartImgView.leftAnchor.constraint(equalTo: titleImgView.rightAnchor, constant: -100).isActive = true
        
        heartImgView2.topAnchor.constraint(equalTo: titleImgView.topAnchor, constant: 100).isActive = true
        heartImgView2.rightAnchor.constraint(equalTo: titleImgView.leftAnchor, constant: 100).isActive = true
    }
    func drawIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        indicator.topAnchor.constraint(equalTo: dataSourceLabel.bottomAnchor).isActive = true
    }
}
