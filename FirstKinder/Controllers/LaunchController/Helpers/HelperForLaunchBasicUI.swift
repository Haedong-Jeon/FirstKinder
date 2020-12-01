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
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        drawTitleImg()
        drawTitleTextView()
        drawKinderTitle()
        drawProgressBar()
    }
    func drawTitleTextView() {
        view.addSubview(titleTextView)
        titleTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: titleImgView.topAnchor).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        titleTextView.text = "퍼스트 킨더"
    }
    func drawTitleImg() {
        view.addSubview(titleImgView)
        titleImgView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleImgView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -30).isActive = true
        titleImgView.loadGif(name: "loading")
    }
    func drawKinderTitle() {
        view.addSubview(kinderTextView)
        kinderTextView.topAnchor.constraint(equalTo: titleImgView.bottomAnchor).isActive = true
        kinderTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    func drawProgressBar() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
        progressBar.topAnchor.constraint(equalTo: kinderTextView.bottomAnchor).isActive = true
        progressBar.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
}
