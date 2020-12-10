//
//  HelperForTextDelegateForChatWrite.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

extension ChatWriteController {
    func textViewDidBeginEditing(_ textView: UITextView) {
        chatBodyTextViewSetUp()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if chatBodyTextView.text == "" {
            chatBodyTextViewSetUp()
        }
    }
    func chatBodyTextViewSetUp() {
        if chatBodyTextView.text == chatPlaceHoldText {
            chatBodyTextView.text = ""
            chatBodyTextView.textColor = .black
        } else if chatBodyTextView.text == "" {
            chatBodyTextView.text = chatPlaceHoldText
            chatBodyTextView.textColor = .placeholderText
        }
    }
}
