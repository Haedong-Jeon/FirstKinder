//
//  ChatWriteController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

class ChatWriteController: UIViewController, UITextViewDelegate {
    var chatBodyTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1
        textView.layer.borderColor = #colorLiteral(red: 0.1889419258, green: 0.1871659458, blue: 0.2520412803, alpha: 1)
        textView.text = chatPlaceHoldText
        textView.textColor = .placeholderText
        return textView
    }()
    let imgPicker = UIImagePickerController()
    func keyboardToolBarSetup() {
        chatBodyTextView.delegate = self
        
        let keyboardToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        keyboardToolbar.barStyle = .default
        keyboardToolbar.items = [
            UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(keyBoardCameraButtonTap)),
            UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(keyBoardPhotoButtonTap)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "완료❤︎", style: .plain, target: self, action: #selector(keyBoardDoneButtonTap))
        ]
        keyboardToolbar.tintColor = .black
        keyboardToolbar.sizeToFit()
        chatBodyTextView.inputAccessoryView = keyboardToolbar
        
    }
    override func viewDidLoad() {
        keyboardToolBarSetup()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureUI()
    }
}
