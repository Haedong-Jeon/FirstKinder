//
//  SelectorForChatWrite.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

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
    func showSuccessMsg() {
        self.chatBodyTextView.text.removeAll()
        let showSuccess = UIAlertController(title: "업로드", message: "업로드 됐어요!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
            self.view.isUserInteractionEnabled = true
            self.navigationController?.popViewController(animated: true)
        }
        showSuccess.addAction(okButton)
        self.present(showSuccess, animated: true, completion: nil)
    }
    
    @objc func handleUpload() {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        indicator.style = .large
        indicator.color = .black
        
        indicator.startAnimating()
        
        view.isUserInteractionEnabled = false
        let uid = NSUUID().uuidString
        let imgFileName = uid
        if chatBodyTextView.text.isEmpty { return }
        if imgView.image == nil {
            uploadText(uid) {
                self.showSuccessMsg()
            }
        } else {
            uploadImg(uid, imgFileName) {
                self.uploadText(uid) {
                    indicator.stopAnimating()
                    self.showSuccessMsg()
                }
            }
        }
    }
    func uploadText(_ uid: String, completion: @escaping() -> Void) {
        var imgFileName = ""
        let deviceVendor = UIDevice.current.identifierForVendor?.uuidString
        if imgView.image == nil {
            imgFileName = "NO IMG"
        } else {
            imgFileName = uid
        }
        let timeStamp = Int(NSDate().timeIntervalSince1970)
        let value: [String: Any] = ["uid": uid, "chat": chatBodyTextView.text!, "imgFileName": imgFileName, "timeStamp": timeStamp, "vendor": deviceVendor]
        
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
    
    func uploadImg(_ uid: String, _ imgFileName: String, completion: @escaping() -> Void) {
        guard let imgData = imgView.image?.jpegData(compressionQuality: 0.3) else { return }
        STORAGE_USER_UPLOAD_IMGS.child(imgFileName).putData(imgData, metadata: nil) { (metaData, error) in
            if error != nil {
                let showError = UIAlertController(title: "업로드", message: "이미지 업로드 중 에러가 발생했어요 ㅜ.ㅜ \(error)", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                showError.addAction(okButton)
                self.present(showError, animated: true, completion: nil)
            }
            completion()
        }
    }
}
