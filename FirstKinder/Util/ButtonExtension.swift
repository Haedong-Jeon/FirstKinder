//
//  ButtonExtension.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/13.
//

import UIKit

extension UIButton {
    func addDetact() {
        self.addTarget(self, action: #selector(detectTapInCell), for: .touchUpInside)
    }
    @objc func detectTapInCell() {
        
    }
}
