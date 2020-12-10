//
//  ChatDetailSelector.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

extension ChatDetailController {
    @objc func handleGearButtonTap() {
        if self.chat?.vendor == UIDevice.current.identifierForVendor?.uuidString {
            //글 쓴 사람임.
            let actionAlertController = UIAlertController()
            let button1 = UIAlertAction(title: "수정할게요", style: .default, handler: nil)
            let button2 = UIAlertAction(title: "삭제할게요", style: .default, handler: nil)
            let button3 = UIAlertAction(title: "닫기", style: .cancel, handler: nil)

            actionAlertController.addAction(button1)
            actionAlertController.addAction(button2)
            actionAlertController.addAction(button3)
            
            self.present(actionAlertController, animated: true, completion: nil)
        } else {
            //글 쓴 사람이 아님.
            let actionAlertController = UIAlertController()
            let button1 = UIAlertAction(title: "신고할 거에요", style: .default) { ACTION in
                self.reportThisUser()
            }
            let button2 = UIAlertAction(title: "이 사람의 글은 더 이상 보기 싫어요", style: .default) { ACTION in
                self.blockThisUser()
            }
            let button3 = UIAlertAction(title: "닫기", style: .cancel, handler: nil)

            actionAlertController.addAction(button1)
            actionAlertController.addAction(button2)
            actionAlertController.addAction(button3)

            self.present(actionAlertController, animated: true, completion: nil)
        }
    }
    func blockThisUser() {
        var reason = ""
        let addReasonAlert = UIAlertController(title: "차단", message: "이유가 뭔가요?", preferredStyle: .alert)
        addReasonAlert.addTextField { textField in
            textField.placeholder = "이 사람 글이 보기 싫은 이유를 알려주세요."
        }
        let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
            self.localSaveBlockedUser()
            reason = addReasonAlert.textFields?[0].text ?? "이유를 안 알려주셨어요."
            self.localSaveBlockedReason(reason: reason)
        }
        addReasonAlert.addAction(okButton)
        self.present(addReasonAlert, animated: true, completion: nil)
    }
    func reportThisUser() {
        
    }
    func localSaveBlockedUser() {
        guard let blocks = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else {
            blockedUserVendors.append(self.chat!.vendor)
            UserDefaults.standard.setValue(blockedUserVendors, forKey: "blockedUsers")
            return
        }
        blockedUserVendors = blocks
        blockedUserVendors.append(self.chat!.vendor)
        UserDefaults.standard.setValue(blockedUserVendors, forKey: "blockedUsers")
    }
    func localSaveBlockedReason(reason: String) {
        guard let reasons = UserDefaults.standard.array(forKey: "blockedReasons") as? [String] else {
            blockedUserReasons.append(reason)
            UserDefaults.standard.setValue(blockedUserReasons, forKey: "blockedReasons")
            return
        }
        blockedUserReasons = reasons
        blockedUserReasons.append(reason)
        UserDefaults.standard.setValue(blockedUserReasons, forKey: "blockedReasons")
    }
}
