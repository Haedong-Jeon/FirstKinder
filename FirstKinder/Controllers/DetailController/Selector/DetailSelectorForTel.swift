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
    @objc func handlePlusButtonTapped() {
        let askAddMyKinderAlert = UIAlertController(title: "관심 어린이집", message: "관심 어린이집에 추가하시겠습니까?", preferredStyle: .alert)
        let okbutton = UIAlertAction(title: "네", style: .default) { ACTION in
            self.saveMyKinder() {
                let successAlert = UIAlertController(title: "관심 어린이집", message: "저장 완료!", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                successAlert.addAction(okButton)
                self.present(successAlert, animated: false, completion: nil)
                
                self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.isEnabled = false
            }
        }
        let noButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        askAddMyKinderAlert.addAction(okbutton)
        askAddMyKinderAlert.addAction(noButton)
        
        self.present(askAddMyKinderAlert, animated: false, completion: nil)
    }
}
