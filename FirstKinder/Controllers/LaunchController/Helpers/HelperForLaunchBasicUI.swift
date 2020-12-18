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
        view.backgroundColor = #colorLiteral(red: 0.1889419258, green: 0.1871659458, blue: 0.2520412803, alpha: 1)
        self.navigationController?.navigationBar.isHidden = true
        drawTitleTextView()
        drawTitleImg()
        drawDataSource()
        drawHearts()
        drawProgress()
        drawGuidance()
        
    }
    func drawTitleTextView() {
        view.addSubview(titleLabel)
        titleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.text = "퍼스트 킨더"
    }
    func drawTitleImg() {
        view.addSubview(titleImgView)
        titleImgView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleImgView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        titleImgView.image = #imageLiteral(resourceName: "girl")
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
        heartImgView.leftAnchor.constraint(equalTo: titleImgView.rightAnchor).isActive = true
        
        heartImgView2.topAnchor.constraint(equalTo: titleImgView.topAnchor, constant: 100).isActive = true
        heartImgView2.rightAnchor.constraint(equalTo: titleImgView.leftAnchor).isActive = true
    }
    func drawProgress() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
        progressBar.widthAnchor.constraint(equalTo: titleImgView.widthAnchor).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        progressBar.topAnchor.constraint(equalTo: dataSourceLabel.bottomAnchor, constant: 20).isActive = true
        progressBar.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }
    func drawGuidance() {
        view.addSubview(guidanceMsgLabel)
        guidanceMsgLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        guidanceMsgLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor).isActive = true
    }
}
