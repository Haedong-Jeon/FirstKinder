//
//  ChatDetailSelector.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

extension ChatDetailController {
    @objc func handleGearButtonTap() {
        if self.chat?.vendor == UIDevice.current.identifierForVendor?.uuidString {
            //글 쓴 사람임.
            let actionAlertController = UIAlertController()
            let button1 = UIAlertAction(title: "수정할게요", style: .default) { ACTION in
                self.editThis()
            }
            let button2 = UIAlertAction(title: "삭제할게요", style: .default) { ACTION in
                self.deleteThis()
            }
            let button3 = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
            
            actionAlertController.addAction(button1)
            actionAlertController.addAction(button2)
            actionAlertController.addAction(button3)
            
            self.present(actionAlertController, animated: true, completion: nil)
        } else {
            //글 쓴 사람이 아님.
            let actionAlertController = UIAlertController()
            let button1 = UIAlertAction(title: "신고할 거에요", style: .default) { ACTION in
                self.reportThisChat()
            }
            let button2 = UIAlertAction(title: "이 사람의 글은 더 이상 보기 싫어요", style: .default) { ACTION in
                self.blockThisUser()
            }
            let button3 = UIAlertAction(title: "닫기", style: .cancel, handler: nil)
            
            if isAlreadyReported() {
                button1.isEnabled = false
            }
            actionAlertController.addAction(button1)
            actionAlertController.addAction(button2)
            actionAlertController.addAction(button3)
            
            self.present(actionAlertController, animated: true, completion: nil)
        }
    }
    func isAlreadyReported() -> Bool {
        var isReported = false
        guard let reportedChat = UserDefaults.standard.array(forKey: "reportedChatList") as? [String] else {
            return false
        }
        reportedChat.forEach({
            if $0 == self.chat!.uid {
                isReported = true
            }
        })
        return isReported
    }
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
    @objc func handleUploadTap() {
        let askAlert = UIAlertController(title: "댓글", message: "댓글을 업로드 할까요?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "네", style: .default) { ACTION in
            self.commentUpload()
        }
        let cancelButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        askAlert.addAction(okButton)
        askAlert.addAction(cancelButton)
        
        self.present(askAlert, animated: true, completion: nil)
    }
    func deleteThis() {
        var deleteCommentUid = [String]()
        comments.forEach({
            if $0.targetChatUid == chat!.uid {
                deleteCommentUid.append($0.uid)
            }
        })
        DB_CHATS.child(chat!.uid).removeValue()
        STORAGE_USER_UPLOAD_IMGS.child(chat!.uid).delete { error in
            print("이미지 삭제 에러 -\(error)")
        }
        deleteCommentUid.forEach({
            DB_COMMENTS.child($0).removeValue()
            STORAGE_COMMENT_IMGS.child($0).delete { (error) in
                //NOTHING
            }
        })
        navigationController?.popViewController(animated: true)
    }
    func editThis() {
        var editWriteController = ChatWriteController()
        editWriteController.editingChat = self.chat
        editWriteController.isEditing = true
        editWriteController.editiedDetailChat = self
        
        navigationController?.pushViewController(editWriteController, animated: true)
    }
    func blockThisUser() {
        var category = ""
        let blockReasonCategoryAlert = UIAlertController(title: "사유", message: "차단 사유를 선택해주세요.", preferredStyle: .actionSheet)
        let button1 = UIAlertAction(title: "불쾌한 게시물", style: .default) { ACTION in
            category = "불쾌한 게시물"
            self.addDetailReason(category: category)
        }
        let button2 = UIAlertAction(title: "부적절한 광고", style: .default) { ACTION in
            category = "부적절한 광고"
            self.addDetailReason(category: category)
        }
        let button3 = UIAlertAction(title: "기타", style: .default) { ACTION in
            category = "기타"
            self.addDetailReason(category: category)
        }
        let button4 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        blockReasonCategoryAlert.addAction(button1)
        blockReasonCategoryAlert.addAction(button2)
        blockReasonCategoryAlert.addAction(button3)
        blockReasonCategoryAlert.addAction(button4)
        
        self.present(blockReasonCategoryAlert, animated: true, completion: nil)
    }
    func blockThisCommentor(_ indexPath: IndexPath) {
        var category = ""
        let blockReasonCategoryAlert = UIAlertController(title: "사유", message: "차단 사유를 선택해주세요.", preferredStyle: .actionSheet)
        let button1 = UIAlertAction(title: "불쾌한 댓글", style: .default) { ACTION in
            category = "불쾌한 댓글"
            self.addDetailReason(category: category, indexPath)
        }
        let button2 = UIAlertAction(title: "부적절한 광고", style: .default) { ACTION in
            category = "부적절한 광고"
            self.addDetailReason(category: category, indexPath)
        }
        let button3 = UIAlertAction(title: "기타", style: .default) { ACTION in
            category = "기타"
            self.addDetailReason(category: category, indexPath)
        }
        let button4 = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        blockReasonCategoryAlert.addAction(button1)
        blockReasonCategoryAlert.addAction(button2)
        blockReasonCategoryAlert.addAction(button3)
        blockReasonCategoryAlert.addAction(button4)
        
        self.present(blockReasonCategoryAlert, animated: true, completion: nil)
    }
    func addDetailReason(category: String) {
        //게시글 차단
        var reason = "이유를 안 알려주셨어요."
        let addReasonAlert = UIAlertController(title: "차단 상세 사유", message: "상세한 사유를 알려주세요", preferredStyle: .alert)
        addReasonAlert.addTextField { textField in
            textField.placeholder = "이 사람 글이 보기 싫은 이유를 알려주세요."
        }
        let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
            self.localSaveBlockedUser()
            reason = addReasonAlert.textFields?[0].text ?? "이유를 안 알려주셨어요."
            self.localSaveBlockedReason(reason: reason)
            self.localSaveBlockReasonCategory(category: category)
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        addReasonAlert.addAction(okButton)
        addReasonAlert.addAction(cancelButton)
        self.present(addReasonAlert, animated: true, completion: nil)
    }
    func addDetailReason(category: String, _ indexPath: IndexPath) {
        //댓글 차단
        var reason = "이유를 안 알려주셨어요."
        let addReasonAlert = UIAlertController(title: "차단 상세 사유", message: "상세한 사유를 알려주세요", preferredStyle: .alert)
        addReasonAlert.addTextField { textField in
            textField.placeholder = "이 사람 댓글이 보기 싫은 이유를 알려주세요."
        }
        let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
            self.localSaveBlockedCommentor(indexPath)
            reason = addReasonAlert.textFields?[0].text ?? "이유를 안 알려주셨어요."
            self.localSaveBlockedReason(reason: reason)
            self.localSaveBlockReasonCategory(category: category)
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        addReasonAlert.addAction(okButton)
        addReasonAlert.addAction(cancelButton)
        self.present(addReasonAlert, animated: true, completion: nil)
    }
    func reportThisChat() {
        let reportCount = chat!.reportCount + 1
        DB_CHATS.child(chat!.uid).updateChildValues(["reportCount": reportCount])
        
        guard let reportedChat = UserDefaults.standard.array(forKey: "reportedChatList") as? [String] else {
            reportedChatList.append(self.chat!.uid)
            UserDefaults.standard.setValue(reportedChatList, forKey: "reportedChatList")
            return
        }
        reportedChatList = reportedChat
        reportedChatList.append(self.chat!.uid)
        UserDefaults.standard.setValue(reportedChatList, forKey: "reportedChatList")
    }
    func localSaveBlockedUser() {
        guard let blocks = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else {
            blockedUserVendors.append(self.chat!.vendor)
            UserDefaults.standard.setValue(blockedUserVendors, forKey: "blockedUsers")
            return
        }
        blockedUserVendors = blocks
        blockedUserVendors.append(self.chat!.vendor)
        UserDefaults.standard.setValue(blockedUserVendors, forKey: "blockedUsers")
    }
    func localSaveBlockedCommentor(_ indexPath: IndexPath) {
        guard let blocks = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else {
            blockedUserVendors.append(self.thisComments[indexPath.row].vendor)
            UserDefaults.standard.setValue(blockedUserVendors, forKey: "blockedUsers")
            return
        }
        blockedUserVendors = blocks
        blockedUserVendors.append(self.thisComments[indexPath.row].vendor)
        UserDefaults.standard.setValue(blockedUserVendors, forKey: "blockedUsers")
        collectionView.reloadData()
    }
    func localSaveBlockedReason(reason: String) {
        guard let reasons = UserDefaults.standard.array(forKey: "blockedReasons") as? [String] else {
            blockedUserReasons.append(reason)
            UserDefaults.standard.setValue(blockedUserReasons, forKey: "blockedReasons")
            return
        }
        blockedUserReasons = reasons
        blockedUserReasons.append(reason)
        UserDefaults.standard.setValue(blockedUserReasons, forKey: "blockedReasons")
    }

    func localSaveBlockReasonCategory(category: String) {
        guard let reasonCategories = UserDefaults.standard.array(forKey: "blockedReasonCategories") as? [String] else {
            blockedReasonCategories.append(category)
            UserDefaults.standard.setValue(blockedReasonCategories, forKey: "blockedReasonCategories")
            return
        }
        blockedReasonCategories = reasonCategories
        blockedReasonCategories.append(category)
        UserDefaults.standard.setValue(blockedReasonCategories, forKey: "blockedReasonCategories")
    }
}
