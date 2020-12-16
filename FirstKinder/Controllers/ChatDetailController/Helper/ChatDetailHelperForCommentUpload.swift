//
//  ChatDetailHelperForCommentUpload.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/11.
//

import UIKit
import Kingfisher

extension ChatDetailController {
    
    func getNewImg(_ cell: CommentCellWithImg) {
        STORAGE_COMMENT_IMGS.child(thisComments[editingIdx!.row].uid).downloadURL { (url, error) in
            if error != nil {
                print("error in img edit \(error)")
            }
            DispatchQueue.global(qos: .background).async {
                let cache = ImageCache.default
                guard let imgData = try? Data(contentsOf: url!) else { return }
                guard let img = UIImage(data: imgData) else { return }
                cache.store(img, forKey: self.thisComments[self.editingIdx!.row].imgFileName)
                DispatchQueue.main.async {
                    cell.imgView.image = img
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
            guard let cell = self.collectionView.cellForItem(at: self.editingIdx!) as? CommentCellWithImg else { return }
            indicator.stopAnimating()
            self.imgView.image = nil
            self.redrawViewsWithoutImg()
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
            //댓글을 수정하는 경우.
            guard let editIdx = self.editingIdx else { return }
            DB_COMMENTS.child(thisComments[editIdx.row].uid).updateChildValues(["commentBody" : commentTextView.text!])
            
            if isEditTargetCommentHasIMg {
                //수정 전 게시글에 이미지가 있다.
                if imgView.image != nil {
                    //새로운 이미지로 교체하는 경우.
                    ImageCache.default.removeImage(forKey: thisComments[editIdx.row].imgFileName)
                    editImg(indicator)
                } else {
                    //이미지를 삭제하는 경우.
                    STORAGE_COMMENT_IMGS.child(thisComments[editIdx.row].imgFileName).delete(completion: nil)
                    DB_COMMENTS.child(thisComments[editIdx.row].uid).updateChildValues(["imgFileName" : "NO IMG"])
                    indicator.stopAnimating()
                    
                }
            } else {
                //수정 전 게시글에 이미지가 없다.
                if imgView.image != nil {
                    //이미지 추가.
                    DB_COMMENTS.child(thisComments[editIdx.row].uid).updateChildValues(["imgFileName" : imgFileName])
                    uploadImg(uid, imgFileName) {
                        indicator.stopAnimating()
                        
                    }
                }
            }
            isEditTargetCommentHasIMg = false
            isCommentEditing = false
            imgView.image = nil
            commentTextView.text = ""
            redrawViewsWithoutImg()
            indicator.stopAnimating()
            self.showSuccessMsg()
            collectionView.reloadData()
            return
        }
        //새로운 댓글을 작성하는 경우
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
        var value = [String: Any]()
        if !self.isCommentToComment {
            value = ["uid": uid, "commentBody": commentTextView.text!, "imgFileName": imgFileName, "timeStamp": timeStamp, "vendor": deviceVendor, "targetChatUid": chat?.uid, "reportCount": 0]
        } else {
            value = ["uid": uid, "commentBody": commentTextView.text!, "imgFileName": imgFileName, "timeStamp": timeStamp, "vendor": deviceVendor, "targetChatUid": chat?.uid, "isCommentToComment": "true", "targetCommentUid": self.targetCommentUid, "reportCount": 0]
        }
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
        self.imgView.image = nil
        self.imgView.removeFromSuperview()
        self.isCommentEditing = false
        self.targetCommentUid = ""
        self.isCommentToComment = false
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
