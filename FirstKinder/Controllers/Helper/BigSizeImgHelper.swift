//
//  BigSizeImgHelper.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/12.
//

import UIKit

extension BigSizeImgViewController {
    func configureUI() {
        view.addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
