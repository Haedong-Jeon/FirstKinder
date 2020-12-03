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
    @objc func handlePlusButtonTap() {
        let askAddMyKinderAlert = UIAlertController(title: "관심 어린이집", message: "관심 어린이집에 추가하시겠습니까?", preferredStyle: .alert)
        let okbutton = UIAlertAction(title: "네", style: .default) { ACTION in
            self.saveMyKinder() {
                let successAlert = UIAlertController(title: "관심 어린이집", message: "저장 완료!", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                successAlert.addAction(okButton)
                self.present(successAlert, animated: false, completion: nil)
                
                self.isFromMyKinder = true
                self.viewDidLoad()
            }
        }
        let noButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        askAddMyKinderAlert.addAction(okbutton)
        askAddMyKinderAlert.addAction(noButton)
        
        self.present(askAddMyKinderAlert, animated: false, completion: nil)
    }
    @objc func handleTrashButtonTap() {
        let askDeleteFromMyKinderAlert = UIAlertController(title: "관심 어린이집", message: "관심 어린이집에서 삭제하시겠습니까?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "네", style: .default) { ACTION in
            self.deleteFromMyKinder() {
                let successAlert = UIAlertController(title: "관심 어린이집", message: "삭제 완료!", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
                    self.navigationController?.popViewController(animated: false)
                }
                successAlert.addAction(okButton)
                self.present(successAlert, animated: false, completion: nil)
            }
        }
        let noButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        askDeleteFromMyKinderAlert.addAction(okButton)
        askDeleteFromMyKinderAlert.addAction(noButton)
        self.present(askDeleteFromMyKinderAlert, animated: false, completion: nil)
    }
}
