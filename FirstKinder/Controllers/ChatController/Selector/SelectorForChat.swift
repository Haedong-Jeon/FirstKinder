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
}
