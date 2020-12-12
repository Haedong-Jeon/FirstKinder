//
//  ChatDetailHelperForCommentUpload.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/11.
//

import UIKit
import Kingfisher

extension ChatDetailController {
    
    func getNewImg(_ cell: CommentCell) {
        STORAGE_COMMENT_IMGS.child(thisComments[editingIdx!.row].uid).downloadURL { (url, error) in
            if error != nil {
                print("error in img edit \(error)")
            }
            DispatchQueue.global(qos: .background).async {
                let resource = ImageResource(downloadURL: url!, cacheKey: self.thisComments[self.editingIdx!.row].imgFileName)
                DispatchQueue.main.async {
                    cell.imgView.kf.setImage(with: resource)
                }
            }
        }
    }
    func setIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        indicator.style = .large
        indicator.color = .black
        return indicator
    }
    func editImg(_ indicator: UIActivityIndicatorView) {
        STORAGE_COMMENT_IMGS.child(thisComments[editingIdx!.row].imgFileName).delete { (error) in
            if error != nil {
                print("error in img delete while editing \(error)")
            }
        }
        uploadImg(thisComments[editingIdx!.row].uid, thisComments[editingIdx!.row].uid) {
            self.showSuccessMsg()
            guard let cell = self.collectionView.cellForItem(at: self.editingIdx!) as? CommentCell else { return }
            cell.editButton.backgroundColor = .black
            cell.editButton.setTitleColor(.white, for: .normal)
            cell.editButton.setTitle("수정", for: .normal)
            indicator.stopAnimating()
            self.getNewImg(cell)
        }
    }
    
    func commentUpload() {
        let indicator = setIndicator()
        indicator.startAnimating()
        let uid = NSUUID().uuidString
        let imgFileName = uid
        if commentTextView.text.isEmpty { return }
        if isCommentEditing {
            guard let editIdx = self.editingIdx else { return }
            if isEditTargetCommentHasIMg {
                if imgView.image != nil {
                    ImageCache.default.removeImage(forKey: thisComments[editIdx.row].imgFileName)
                    editImg(indicator)
                } else {
                    STORAGE_COMMENT_IMGS.child(thisComments[editIdx.row].imgFileName).delete(completion: nil)
                    DB_COMMENTS.child(thisComments[editIdx.row].uid).updateChildValues(["imgFileName" : "NO IMG"])
                    indicator.stopAnimating()
                }
            } else {
                if imgView.image != nil {
                    DB_COMMENTS.child(thisComments[editIdx.row].uid).updateChildValues(["imgFileName" : imgFileName])
                    uploadImg(uid, imgFileName) {}
                }
                DB_COMMENTS.child(thisComments[editIdx.row].uid).updateChildValues(["commentBody" : commentTextView.text!])
                self.showSuccessMsg()
            }
            isEditTargetCommentHasIMg = false
            isCommentEditing = false
            editButtonsUnlock()
            imgView.image = nil
            commentTextView.text = ""
            redrawViewsWithoutImg()
            indicator.stopAnimating()
            collectionView.reloadData()
            return
        }
        if imgView.image == nil {
            uploadText(uid) {
                indicator.stopAnimating()
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
        DB_CHATS.child(self.chat!.uid).updateChildValues(["commentCount": commentCount])
    }
}