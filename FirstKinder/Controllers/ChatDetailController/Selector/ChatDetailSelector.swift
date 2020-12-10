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
            let button1 = UIAlertAction(title: "신고할 거에요", style: .default, handler: nil)
            let button2 = UIAlertAction(title: "이 사람의 글은 더 이상 보기 싫어요", style: .default, handler: nil)
            let button3 = UIAlertAction(title: "닫기", style: .cancel, handler: nil)

            actionAlertController.addAction(button1)
            actionAlertController.addAction(button2)
            actionAlertController.addAction(button3)
            
            self.present(actionAlertController, animated: true, completion: nil)

        }
    }
}
