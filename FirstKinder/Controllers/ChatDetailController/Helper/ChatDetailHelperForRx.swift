//
//  ChatDetailHelperForRx.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/13.
//

import UIKit

extension ChatDetailController {
    func setRx() {
        comment$ = commentTextView.rx.text.orEmpty.asObservable().map { text -> Bool in
            return text.count > 0
        }
    }
    func setSubscriberForRx() {
        comment$?.subscribe(onNext: { checker in
            if checker {
                self.uploadButton.isEnabled = true
            } else {
                self.uploadButton.isEnabled = false
            }
        })
    }
}
