//
//  ChatDetailHelperForCommentUpload.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/11.
//

import UIKit

extension ChatDetailController {
    func commentUpload() {
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
        if commentTextView.text.isEmpty { return }
        if imgView.image == nil {
            uploadText(uid) {
                self.showSuccessMsg()
                indicator.stopAnimating()
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
        let value: [String: Any] = ["uid": uid, "commentBody": commentTextView.text!, "imgFileName": imgFileName, "timeStamp": timeStamp, "vendor": deviceVendor, "targetChatUid": chat?.uid]
        
        DB_COMMENTS.child(uid).updateChildValues(value) { (error, ref) in
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
        STORAGE_COMMENT_IMGS.child(imgFileName).putData(imgData, metadata: nil) { (metaData, error) in
            if error != nil {
                let showError = UIAlertController(title: "업로드", message: "이미지 업로드 중 에러가 발생했어요 ㅜ.ㅜ \(error?.localizedDescription)", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default, handler: nil)
                showError.addAction(okButton)
                self.present(showError, animated: true, completion: nil)
            }
            completion()
        }
    }
    func showSuccessMsg() {
        self.commentTextView.text.removeAll()
        self.imgView.removeFromSuperview()
        let showSuccess = UIAlertController(title: "댓글", message: "댓글이 업로드 됐어요!", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
            self.view.isUserInteractionEnabled = true
            self.commentCountUp()
        }
        showSuccess.addAction(okButton)
        self.present(showSuccess, animated: true, completion: nil)
    }
    func commentCountUp() {
        let commentCount = self.thisComments.count
        let value: [String: Any] = ["uid": self.chat!.uid, "chat": self.chat!.chatBody, "imgFileName": self.chat!.imgFileName, "timeStamp": self.chat!.timeStamp, "vendor": self.chat!.vendor, "category": self.chat!.category, "commentCount": commentCount]
        DB_CHATS.child(self.chat!.uid).updateChildValues(value)
    }
}
