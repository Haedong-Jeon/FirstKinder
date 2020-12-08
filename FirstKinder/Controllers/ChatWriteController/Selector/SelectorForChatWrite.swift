//
//  SelectorForChatWrite.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
import FirebaseDatabase

extension ChatWriteController {
    @objc func keyBoardCameraButtonTap() {
        imgPicker.sourceType = .camera
        present(imgPicker, animated: true, completion: nil)
    }
    @objc func keyBoardPhotoButtonTap() {
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: true, completion: nil)
    }
    @objc func keyBoardDoneButtonTap() {
        view.endEditing(true)
    }
    @objc func handleEraseImgTap() {
        if imgView.image != nil {
            imgView.image = nil
            redrawViewsWithoutImg()
        }
    }
    @objc func handleUpload() {
        if chatBodyTextView.text.isEmpty { return }
        upload {
            self.chatBodyTextView.text.removeAll()
            let showSuccess = UIAlertController(title: "업로드", message: "업로드 됐어요!", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
                self.navigationController?.popViewController(animated: true)
            }
            showSuccess.addAction(okButton)
            self.present(showSuccess, animated: true, completion: nil)
        }
    }
    
    func upload(completion: @escaping() -> Void) {
        let uid = NSUUID().uuidString
        let value: [String: Any] = ["uid": uid, "chat": chatBodyTextView.text]
        
        DB_CHATS.child(uid).updateChildValues(value) { (error, ref) in
            if error != nil {
                let showError = UIAlertController(title: "업로드", message: "에러가 발생했어요 ㅜ.ㅜ", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                showError.addAction(okButton)
                self.present(showError, animated: true, completion: nil)
            }
            completion()
        }
    }
}
