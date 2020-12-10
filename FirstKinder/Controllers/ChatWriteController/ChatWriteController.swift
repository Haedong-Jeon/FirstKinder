//
//  ChatWriteController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

class ChatWriteController: UIViewController, UITextViewDelegate {
    var categoryRadioButtonView = RadioButtonView()
    var chatBodyTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = chatPlaceHoldText
        textView.textColor = .placeholderText
        return textView
    }()
    var imgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.layer.cornerRadius = 5
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.clipsToBounds = true
        return imgView
    }()
    let imgPicker = UIImagePickerController()
    func keyboardToolBarSetup() {
        chatBodyTextView.delegate = self
        imgPicker.delegate = self
        
        let keyboardToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        keyboardToolbar.barStyle = .default
        keyboardToolbar.items = [
            UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(keyBoardCameraButtonTap)),
            UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(keyBoardPhotoButtonTap)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(keyBoardDoneButtonTap))
        ]
        keyboardToolbar.tintColor = .black
        keyboardToolbar.sizeToFit()
        chatBodyTextView.inputAccessoryView = keyboardToolbar
        
    }
    override func viewDidLoad() {
        keyboardToolBarSetup()
        configureUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "이야기 쓰기"
        let uploadButton = UIBarButtonItem(title: "완료❤︎", style: .plain, target: self, action: #selector(handleUpload))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = uploadButton

    }
}
