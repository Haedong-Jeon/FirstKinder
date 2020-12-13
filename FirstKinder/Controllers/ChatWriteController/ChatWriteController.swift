//
//  ChatWriteController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
import Kingfisher
import RxSwift

class ChatWriteController: UIViewController, UITextViewDelegate {
    var chatBody$: Observable<Bool>?
    var categoryRadioButtonView = RadioButtonView()
    var editingChat: Chat?
    var editiedDetailChat: ChatDetailController?
    override var isEditing: Bool {
        didSet {
            chatBodyTextView.text = editingChat?.chatBody
            category = editingChat?.category ?? "어린이집"
            if editingChat?.imgFileName != "NO IMG" {
                imgView.image = DBUtil.shared.loadImgFromCache(editingChat!.imgFileName)
            }
        }
    }
    var category = ""
    let uploadButton = UIBarButtonItem(title: "완료❤︎", style: .plain, target: self, action: #selector(handleUpload))
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
        setRx()
        setSubscriberForRx()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "이야기 쓰기"
        uploadButton.tintColor = .gray
        uploadButton.isEnabled = false
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = uploadButton

        if editingChat != nil {
            //게시글 수정중.
            if imgView.image != nil {
                redrawViewsWithImg()
            } else {
                redrawViewsWithoutImg()
            }
        }
    }
}
