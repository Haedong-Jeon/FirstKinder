//
//  HelperForLaunchBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit

extension LaunchController {
    func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        drawTitleImg()
        drawKinderTitle()
    }
    func drawTitleImg() {
        view.addSubview(titleImgView)
        titleImgView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        titleImgView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -30).isActive = true
        titleImgView.image = #imageLiteral(resourceName: "TitleImg")
    }
    func drawKinderTitle() {
        view.addSubview(kinderTextView)
        kinderTextView.topAnchor.constraint(equalTo: titleImgView.bottomAnchor).isActive = true
        kinderTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
