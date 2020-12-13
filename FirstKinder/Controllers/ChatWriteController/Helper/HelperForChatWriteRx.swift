//
//  HelperForChatWriteRx.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/13.
//

import UIKit
import RxSwift
import RxCocoa

extension ChatWriteController {
    func setRx() {
        chatBody$ = chatBodyTextView.rx.text.orEmpty.asObservable().map { text -> Bool in
            return text.count > 0
        }
    }
    func setSubscriberForRx() {
        chatBody$?.subscribe(onNext: { checker in
            if checker {
                self.uploadButton.tintColor = .link
                self.uploadButton.isEnabled = true
            } else {
                self.uploadButton.tintColor = .gray
                self.uploadButton.isEnabled = false
            }
        })
    }
}
