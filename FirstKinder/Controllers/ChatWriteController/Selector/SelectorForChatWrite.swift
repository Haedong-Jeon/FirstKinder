//
//  SelectorForChatWrite.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
import Kingfisher
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
        // 게시글 수정하는 상황
        if editingChat != nil {
            view.isUserInteractionEnabled = false
            if categoryRadioButtonView.firstButton.tintColor == .red {
                category = "어린이집"
            } else if categoryRadioButtonView.secondButton.tintColor == .red {
                category = "육아"
            } else if categoryRadioButtonView.thirdButton.tintColor == .red {
                category = "잡담"
            }
            DB_CHATS.child(editingChat!.uid).updateChildValues(["chat": chatBodyTextView.text!])
            DB_CHATS.child(editingChat!.uid).updateChildValues(["category": category])
            
            if editingChat!.imgFileName != "NO IMG" {
                //이미지가 있었는데 지운 경우
                if imgView.image == nil {
                    ImageCache.default.removeImage(forKey: editingChat!.imgFileName)
                    DB_CHATS.child(editingChat!.uid).updateChildValues(["imgFileName": "NO IMG"])
                    STORAGE_USER_UPLOAD_IMGS.child(editingChat!.imgFileName).delete { (error) in
                        if error != nil {
                            print("error in editing chat image \(error)")
                        }
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                } else {
                    //이미지가 있었는데 교체한 경우
                    if imgView.image != nil {
                        STORAGE_USER_UPLOAD_IMGS.child(editingChat!.imgFileName).delete(completion: nil)
                        ImageCache.default.removeImage(forKey: editingChat!.imgFileName)
                        uploadImg(editingChat!.uid, editingChat!.imgFileName) {
                            self.showSuccessMsg()
                            indicator.stopAnimating()
                            self.view.isUserInteractionEnabled = true
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
            } else {
                //이미지가 없었는데 생긴 경우
                let imgFileName = editingChat!.uid
                DB_CHATS.child(editingChat!.uid).updateChildValues(["imgFileName": imgFileName])
                uploadImg(editingChat!.uid, imgFileName) {
                    self.showSuccessMsg()
                    indicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            indicator.stopAnimating()
            view.isUserInteractionEnabled = true
            self.navigationController?.popToRootViewController(animated: true)
            return
        }
        
        //새 게시글 쓰는 상황
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
        if categoryRadioButtonView.firstButton.tintColor == .red {
            category = "어린이집"
        } else if categoryRadioButtonView.secondButton.tintColor == .red {
            category = "육아"
        } else if categoryRadioButtonView.thirdButton.tintColor == .red {
            category = "잡담"
        }
        let timeStamp = Int(NSDate().timeIntervalSince1970)
        let value: [String: Any] = ["uid": uid, "chat": chatBodyTextView.text!, "imgFileName": imgFileName, "timeStamp": timeStamp, "vendor": deviceVendor, "category": category, "commentCount": 0, "reportCount": 0]
        
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
                let showError = UIAlertController(title: "업로드", message: "이미지 업로드 중 에러가 발생했어요 ㅜ.ㅜ \(error?.localizedDescription)", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                showError.addAction(okButton)
                self.present(showError, animated: true, completion: nil)
            }
            completion()
        }
    }
}
