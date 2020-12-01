//
//  DetailSelectorForTel.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit

extension DetailController {
    @objc func handleTelTap() {
        let urlString = "tel://" + kinder.tel
        guard let numberURL = URL(string: urlString) else { return }
        UIApplication.shared.open(numberURL, options: [:], completionHandler: nil)
    }
}
