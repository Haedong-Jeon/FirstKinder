//
//  ChatDetailHelperForCollectionViewDelegate.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit
import Kingfisher

extension ChatDetailController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as? ChatDetailHeader else {
            return UICollectionReusableView()
        }
        header.chat = self.chat
        header.imgView.isUserInteractionEnabled = true
        header.backgroundColor = .white
        header.setUp()
        header.imgView.addMakeBigFunction()
        header.commentCountLabel.text = "댓글 \(thisComments.count)"
        if self.chat?.imgFileName == "NO IMG" {
            header.configureUIWithoutImg()
        } else {
            header.configureUIWithImg()
        }
        let thisUserVendor = chat!.vendor
        var thisUserReportCount = 0
        chats.forEach({
            if $0.vendor == thisUserVendor {
                thisUserReportCount += $0.reportCount
            }
        })
        if thisUserReportCount < 1 {
            header.faceImgView.image = #imageLiteral(resourceName: "happy")
        } else if thisUserReportCount < 3 {
            header.faceImgView.image = #imageLiteral(resourceName: "smile")
        } else if thisUserReportCount < 6 {
            header.faceImgView.image = #imageLiteral(resourceName: "neutral")
        } else {
            header.faceImgView.image = #imageLiteral(resourceName: "sad")
        }
        return header
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thisComments.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getEstimatedHeightFromDummyCell(indexPath)
        return CGSize(width: collectionView.frame.width, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if thisComments[(indexPath.row % self.thisComments.count)].isCommentToComment != nil { return }
        let askCommentToCommentAlert = UIAlertController(title: "대댓글", message: "이 댓글에 대댓글을 다시겠습니까?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "네", style: .default) { ACTION in
            self.isCommentToComment = true
            self.targetCommentUid = self.thisComments[(indexPath.row % self.thisComments.count)].uid
            self.commentTextView.becomeFirstResponder()
        }
        let cancelButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        askCommentToCommentAlert.addAction(okButton)
        askCommentToCommentAlert.addAction(cancelButton)
        
        self.present(askCommentToCommentAlert, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let targetComment = self.thisComments[indexPath.row % thisComments.count]
        if targetComment.isCommentToComment == nil && targetComment.imgFileName == "NO IMG" {
            //MARK: - 이미지가 없는 일반 댓글 셀 설정
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellReuseIdentifier, for: indexPath) as? CommentCell else {
                return UICollectionViewCell()
            }
            cell.vendorLabel.text = getVendor(indexPath: indexPath)
            cell.timeLabel.text = getTime(indexPath: indexPath)
            if isBlockedUserComment(indexPath) {
                setBlockedCellComment(cell)
            } else {
                cell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            }
            if isThisUserComment(indexPath) {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "more"), for: .normal)
            } else {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "output-onlinepngtools (5)"), for: .normal)
            }
            cell.addFunctionToVerticalDots()
            cell.thisIdxPath = indexPath
            cell.deleteDelegate = self
            cell.faceImgView.image = setCommentFace(indexPath)
            
            return cell
        } else if targetComment.isCommentToComment == nil && targetComment.imgFileName != "NO IMG" {
            //MARK: - 이미지가 있는 일반 댓글 셀 설정
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellWithImgReuseIdentifier, for: indexPath) as? CommentCellWithImg else {
                return UICollectionViewCell()
            }
            cell.vendorLabel.text = getVendor(indexPath: indexPath)
            cell.timeLabel.text = getTime(indexPath: indexPath)
            getImg(cell, indexPath)
            if isBlockedUserComment(indexPath) {
                setBlockedCellComment(cell)
                cell.imgView.image = #imageLiteral(resourceName: "block")
            } else {
                cell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            }
            if isThisUserComment(indexPath) {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "more"), for: .normal)
            } else {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "output-onlinepngtools (5)"), for: .normal)
            }
            cell.thisIdxPath = indexPath
            cell.deleteDelegate = self
            cell.imgView.addMakeBigFunction()
            cell.addFunctionToVerticalDots()
            cell.faceImgView.image = setCommentFace(indexPath)
            return cell
        } else if targetComment.isCommentToComment != nil && targetComment.imgFileName == "NO IMG" {
            //MARK: - 이미지가 없는 대댓글 셀 설정
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentToCommentCellReuseIdentifier, for: indexPath) as? CommentToCommentCell else {
                return UICollectionViewCell()
            }
            cell.vendorLabel.text = getVendor(indexPath: indexPath)
            cell.timeLabel.text = getTime(indexPath: indexPath)
            if isBlockedUserComment(indexPath) {
                setBlockedCellComment(cell)
            } else {
                cell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            }
            if isThisUserComment(indexPath) {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "more"), for: .normal)
            } else {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "output-onlinepngtools (5)"), for: .normal)
            }
            cell.thisIdxPath = indexPath
            cell.deleteDelegate = self
            cell.addFunctionToVerticalDots()
            cell.faceImgView.image = setCommentFace(indexPath)
            return cell
        } else if targetComment.isCommentToComment != nil && targetComment.imgFileName != "NO IMG" {
            //MARK: - 이미지가 있는 대댓글 셀 설정
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentToCommentCellWithImgReuseIdentifier, for: indexPath) as? CoToCoCellWithImg else {
                return UICollectionViewCell()
            }
            cell.vendorLabel.text = getVendor(indexPath: indexPath)
            cell.timeLabel.text = getTime(indexPath: indexPath)
            getImg(cell, indexPath)
            if isBlockedUserComment(indexPath) {
                setBlockedCellComment(cell)
                cell.imgView.image = #imageLiteral(resourceName: "block")
            } else {
                cell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            }
            cell.imgView.addMakeBigFunction()
            if isThisUserComment(indexPath) {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "more"), for: .normal)
            } else {
                cell.verticalDotButton.setImage(#imageLiteral(resourceName: "output-onlinepngtools (5)"), for: .normal)
            }
            cell.thisIdxPath = indexPath
            cell.deleteDelegate = self
            cell.addFunctionToVerticalDots()
            cell.faceImgView.image = setCommentFace(indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: getEstimatedHeightByDummyHeader())
    }
    //MARK: - 헤더 사이즈 계산
    func getEstimatedHeightByDummyHeader() -> CGFloat {
        let width = view.frame.width - 10
        let estimatedHeight: CGFloat = 10000000
        let dummyHeader = ChatDetailHeader(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
        dummyHeader.chat = chat
        dummyHeader.setUp()
        if self.chat?.imgFileName == "NO IMG" {
            dummyHeader.configureUIWithoutImg()
        } else {
            dummyHeader.configureUIWithImg()
        }
        dummyHeader.layoutIfNeeded()
        let estimateSize = dummyHeader.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
        return estimateSize.height
    }
    //MARK: - 셀 사이즈 계산
    func getEstimatedHeightFromDummyCell(_ indexPath: IndexPath) -> CGFloat{
        let targetComment = self.thisComments[indexPath.row % thisComments.count]
        let width = view.frame.width - 10
        let estimatedHeight: CGFloat = 800.0
        if targetComment.isCommentToComment == nil && targetComment.imgFileName == "NO IMG" {
            //이미지가 없는 일반 댓글
            let dummyCell = CommentCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
            dummyCell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            dummyCell.layoutIfNeeded()
            let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
            return estimateSize.height
        } else if targetComment.isCommentToComment == nil && targetComment.imgFileName != "NO IMG" {
            //이미지가 있는 일반 댓글
            let dummyCell = CommentCellWithImg(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
            dummyCell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            dummyCell.layoutIfNeeded()
            let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
            return estimateSize.height
        } else if targetComment.isCommentToComment != nil && targetComment.imgFileName == "NO IMG" {
            //이미지가 없는 대댓글
            let dummyCell = CommentToCommentCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
            dummyCell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            dummyCell.layoutIfNeeded()
            let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
            return estimateSize.height
        } else if targetComment.isCommentToComment != nil && targetComment.imgFileName != "NO IMG" {
            //이미지가 있는 대댓글
            let dummyCell = CoToCoCellWithImg(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
            dummyCell.commentBodyLabel.text = thisComments[indexPath.row % thisComments.count].commentBody
            dummyCell.layoutIfNeeded()
            let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
            return estimateSize.height
        }
        return 1
    }
    func getVendor(indexPath: IndexPath) -> String {
        let fullVendorString = thisComments[(indexPath.row % self.thisComments.count)].vendor
        let splitedVendorString = fullVendorString.components(separatedBy: "-")
        var vendor = splitedVendorString[0]
        if fullVendorString == chat?.vendor {
            vendor = vendor + " (글쓴이)"
            let attributedStr = NSMutableAttributedString(string: vendor)
            let ns: NSString = vendor as NSString
            let rangeForAuthor = ns.range(of: "(글쓴이)")
            attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link , range: rangeForAuthor)
            return vendor
        }
        return vendor
    }
    func getTime(indexPath: IndexPath) -> String {

        let now = Int(NSDate().timeIntervalSince1970)
        
        var elapsedTime = (now - thisComments[indexPath.row % thisComments.count].timeStamp) / 60
        if elapsedTime <= 0 {
            return "방금 전"
        } else if elapsedTime < 60 {
            return "\(elapsedTime)분 전"
        } else if elapsedTime < 1440 {
            elapsedTime = elapsedTime / 60
            return "\(elapsedTime)시간 전"
        } else if elapsedTime < 10080 {
            elapsedTime = elapsedTime / (60 * 24)
            return "\(elapsedTime)일 전"
        } else if elapsedTime < 43200 {
            elapsedTime = elapsedTime / (60 * 24 * 7)
            return "\(elapsedTime)주 전"
        } else {
            elapsedTime = elapsedTime / (60 * 24 * 30)
            return "\(elapsedTime)달 전"
        }
    }
    func getImg(_ cell: CommentCellWithImg, _ indexPath: IndexPath) {
        cell.imgView.kf.indicatorType = .activity
        if DBUtil.shared.loadImgFromCache(thisComments[indexPath.row % thisComments.count].imgFileName) == nil {
            DispatchQueue.main.async {
                cell.imgView.kf.indicator?.startAnimatingView()
            }
            DBUtil.shared.loadChatImgsFromStorage(thisComments[indexPath.row % thisComments.count].imgFileName) { url in
                let resource = ImageResource(downloadURL: url, cacheKey: self.thisComments[indexPath.row % self.thisComments.count].imgFileName)
                DispatchQueue.main.async {
                    cell.imgView.kf.setImage(with: resource)
                    cell.imgView.kf.indicator?.stopAnimatingView()
                }
            }
        } else {
            cell.imgView.image = DBUtil.shared.loadImgFromCache(thisComments[indexPath.row % thisComments.count].imgFileName)
            
        }
    }
    func isThisUserComment(_ indexPath: IndexPath) -> Bool {
        var check = false
        if thisComments[indexPath.row % thisComments.count].vendor ==  UIDevice.current.identifierForVendor?.uuidString {
            check = true
        }
        return check
    }
    func setCommentFace(_ indexPath: IndexPath) -> UIImage {
        let commentVendor = thisComments[indexPath.row % thisComments.count].vendor
        var commentorReportCount = 0
        chats.forEach({
            if $0.vendor == commentVendor {
                commentorReportCount += $0.reportCount
            }
        })
        if commentorReportCount < 1 {
            return #imageLiteral(resourceName: "happy")
        } else if commentorReportCount < 3 {
            return #imageLiteral(resourceName: "smile")
        } else if commentorReportCount < 6 {
            return #imageLiteral(resourceName: "neutral")
        } else {
            return #imageLiteral(resourceName: "sad")
        }
    }
    func isBlockedUserComment(_ indexPath: IndexPath) -> Bool {
        guard let blockedUsers = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else {
            return false
        }
        for vendor in blockedUsers {
            if vendor == thisComments[indexPath.row].vendor {
                return true
            }
        }
        return false
    }
    func setBlockedCellComment(_ cell: CommentCell) {
        cell.commentBodyLabel.text = "(system) 차단된 사용자의 댓글입니다."
        let attributedStr = NSMutableAttributedString(string: cell.commentBodyLabel.text!)
        let ns: NSString = cell.commentBodyLabel.text! as NSString
        let rangeForSystem = ns.range(of: "(system)")
        let rangeForComment = ns.range(of: "차단된 사용자의 댓글입니다.")
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: rangeForSystem)
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray , range: rangeForComment)
        cell.commentBodyLabel.attributedText = attributedStr
    }
    func setBlockedCellComment(_ cell: CommentCellWithImg) {
        cell.commentBodyLabel.text = "(system) 차단된 사용자의 댓글입니다."
        let attributedStr = NSMutableAttributedString(string: cell.commentBodyLabel.text!)
        let ns: NSString = cell.commentBodyLabel.text! as NSString
        let rangeForSystem = ns.range(of: "(system)")
        let rangeForComment = ns.range(of: "차단된 사용자의 댓글입니다.")
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: rangeForSystem)
        attributedStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray , range: rangeForComment)
        cell.commentBodyLabel.attributedText = attributedStr
    }
}

extension ChatDetailController: CommentDeleteDelegate {
    func dotTap(indexPath: IndexPath) {
        if thisComments[(indexPath.row % self.thisComments.count)].vendor == UIDevice.current.identifierForVendor?.uuidString {
            
            let askAlertController = UIAlertController()
            let deleteButton = UIAlertAction(title: "삭제", style: .default) { ACTTION in
                self.delete(indexPath: indexPath)
            }
            let editButton = UIAlertAction(title: "수정", style: .default) { ACTTION in
                self.edit(indexPath: indexPath)
            }
            let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            askAlertController.addAction(deleteButton)
            askAlertController.addAction(editButton)
            askAlertController.addAction(cancelButton)
            
            self.present(askAlertController, animated: true, completion: nil)
        } else {
            let askAlertController = UIAlertController()
            let reportButton = UIAlertAction(title: "이 댓글 신고할래요", style: .default) { ACTTION in
                self.reportThisComment(indexPath)
            }
            let blockButton = UIAlertAction(title: "이 사람 차단할래요", style: .default) { ACTTION in
                self.blockThisCommentor(indexPath)
            }
            let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            askAlertController.addAction(reportButton)
            askAlertController.addAction(blockButton)
            askAlertController.addAction(cancelButton)
            
            if isAlreadyBlockedUser(indexPath) {
                blockButton.isEnabled = false
            }
            if isAlreadyReportedComment(indexPath) {
                reportButton.isEnabled = false
            }
            self.present(askAlertController, animated: true, completion: nil)
        }
    }
    func edit(indexPath: IndexPath) {
        if self.isCommentEditing {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CommentCell else {
                return
            }
            editCancel(cell)
            redrawViewsWithoutImg()
            return
        }
        drawEditingUI(indexPath: indexPath)
        
        self.isCommentEditing = true
        self.editingIdx = indexPath
    }
    func drawEditingUI(indexPath: IndexPath) {
        commentTextView.text = thisComments[(indexPath.row % self.thisComments.count)].commentBody
        if thisComments[(indexPath.row % self.thisComments.count)].imgFileName != "NO IMG" {
            self.isEditTargetCommentHasIMg = true
            redrawViewsWithImg()
            self.imgView.image = DBUtil.shared.loadImgFromCache(thisComments[(indexPath.row % self.thisComments.count)].imgFileName)
        }
    }
    func editCancel(_ cell: CommentCell) {
        self.isCommentEditing = false
        self.isEditTargetCommentHasIMg = false
        self.commentTextView.text = ""
        
    }
    func delete(indexPath: IndexPath) {
        self.commentToComments.forEach({
            if $0.targetCommentUid == self.thisComments[(indexPath.row % self.thisComments.count)].uid {
                DB_COMMENTS.child($0.uid).removeValue()
                STORAGE_COMMENT_IMGS.child($0.imgFileName).delete { error in
                    
                }
            }
        })
        DB_COMMENTS.child(thisComments[(indexPath.row % self.thisComments.count)].uid).removeValue()
        STORAGE_COMMENT_IMGS.child(thisComments[(indexPath.row % self.thisComments.count)].imgFileName).delete { error in
            
        }
        thisComments.remove(at: (indexPath.row % self.thisComments.count))
        commentCountDown()
        collectionView.reloadData()
    }
    func commentCountDown() {
        let commentCount = thisComments.count
        DB_CHATS.child(self.chat!.uid).updateChildValues(["commentCount": commentCount])
    }
    func reportThisComment(_ indexPath: IndexPath) {
        let targetComment = thisComments[indexPath.row]
        let reportCount = targetComment.reportCount + 1
        DB_COMMENTS.child(targetComment.uid).updateChildValues(["reportCount": reportCount])
        
        guard let reportedComment = UserDefaults.standard.array(forKey: "reportedCommenttList") as? [String] else {
            reportedCommentList.append(targetComment.uid)
            UserDefaults.standard.setValue(reportedCommentList, forKey: "reportedCommenttList")
            return
        }
        reportedCommentList = reportedComment
        reportedCommentList.append(targetComment.uid)
        UserDefaults.standard.setValue(reportedCommentList, forKey: "reportedCommenttList")
    }
    func isAlreadyReportedComment(_ indexPath: IndexPath) -> Bool {
        let targetComment = thisComments[indexPath.row]
        var isReported = false
        guard let reportedComment = UserDefaults.standard.array(forKey: "reportedCommenttList") as? [String] else {
            return false
        }
        reportedComment.forEach({
            if $0 == targetComment.uid {
                isReported = true
            }
        })
        return isReported
    }
    func isAlreadyBlockedUser(_ indexPath: IndexPath) -> Bool {
        guard let blockedUsers = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else {
            return false
        }
        for vendor in blockedUsers {
            if thisComments[indexPath.row].vendor == vendor {
                return true
            }
        }
        return false
    }
}


