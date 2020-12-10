//
//  SelectorForParentsChat.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

extension ChatController {
    @objc func handleChatTap() {
        let askWriteAlert = UIAlertController(title: "새 이야기", message: "새 이야기를 작성하시겠습니까?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "네", style: .default) { ACTION in
            let writeController = ChatWriteController()
            self.navigationController?.pushViewController(writeController, animated: true)
        }
        let noButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        askWriteAlert.addAction(okButton)
        askWriteAlert.addAction(noButton)
        
        self.present(askWriteAlert, animated: true, completion: nil)
    }
    @objc func handleGearTap() {
        let actionSheetAlert = UIAlertController()
        let button1 = UIAlertAction(title: "차단 목록 관리 할거에요", style: .default) { ACTION in
            let blockedUserController = BlockedUserController(collectionViewLayout: UICollectionViewFlowLayout())
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            transition.type = .fade
            
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(blockedUserController, animated: false)

        }
        var button2 = UIAlertAction()
        if !self.isShowingMyChats {
            button2 = UIAlertAction(title: "내가 쓴 글만 모아 볼거에요", style: .default) { ACTION in
                self.nowChats = self.nowChats
                    .filter({$0.vendor == UIDevice.current.identifierForVendor?.uuidString})
                self.isShowingMyChats = true
            }
        } else {
            button2 = UIAlertAction(title: "전체 글 볼거에요", style: .default) { ACTION in
                if self.blockedUsers.isEmpty {
                    self.nowChats = chats
                } else {
                    self.loadChatWithoutBlockedUsers()
                }
                self.isShowingMyChats = false
            }
        }
        let button3 = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
        
        actionSheetAlert.addAction(button1)
        actionSheetAlert.addAction(button2)
        actionSheetAlert.addAction(button3)
        
        self.present(actionSheetAlert, animated: true, completion: nil)
    }
}
