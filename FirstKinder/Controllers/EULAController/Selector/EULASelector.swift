//
//  EULASelector.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/17.
//

import UIKit

extension EULAController {
    @objc func handleAgreeButtonTouched() {
        UserDefaults.standard.set(true,forKey: "EULA")
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(MainController(), animated: false)
    }
    @objc func handleNotAgreeButtonTouched() {
        UserDefaults.standard.set(false,forKey: "EULA")
        let notAgreeAlert = UIAlertController(title: "최종사용자 동의", message: "동의하지 않으면 앱을 사용할 수 없습니다.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        notAgreeAlert.addAction(okButton)
        
        present(notAgreeAlert, animated: false, completion: nil)
    }
}
