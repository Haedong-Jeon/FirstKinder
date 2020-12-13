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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellReuseIdentifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        cell.deleteDelegate = self
        cell.thisIdxPath = indexPath
        cell.imgView.removeFromSuperview()
        cell.commentBodyLabel.removeFromSuperview()
        drawVendor(cell, indexPath)
        drawVerticalDots(cell, indexPath)
        drawTimeLabel(cell, indexPath)
        drawBorderLine(cell, indexPath)
        cell.commentBodyLabel.text = thisComments[indexPath.row].commentBody
        if thisComments[indexPath.row].imgFileName != "NO IMG" {
            drawCellWithImg(cell, indexPath)
        } else {
            drawCellWithoutImg(cell)
        }
        cell.backgroundColor = .white
        
        let commentorVendor = thisComments[indexPath.row].vendor
        var commentorReportCount = 0
        chats.forEach({
            if $0.vendor == commentorVendor {
                commentorReportCount += $0.reportCount
            }
        })
        if commentorReportCount < 1 {
            cell.faceImgView.image = #imageLiteral(resourceName: "happy")
        } else if commentorReportCount < 3 {
            cell.faceImgView.image = #imageLiteral(resourceName: "smile")
        } else if commentorReportCount < 6 {
            cell.faceImgView.image = #imageLiteral(resourceName: "neutral")
        } else {
            cell.faceImgView.image = #imageLiteral(resourceName: "sad")
        }
        cell.contentView.isUserInteractionEnabled = true
        cell.addFunctionToVerticalDots()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: getEstimatedHeightByDummyHeader())
    }
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
    func getEstimatedHeightFromDummyCell(_ indexPath: IndexPath) -> CGFloat{
        let width = view.frame.width - 10
        let estimatedHeight: CGFloat = 800.0
        let dummyCell = CommentCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
        drawVendor(dummyCell, indexPath)
        dummyCell.commentBodyLabel.text = thisComments[indexPath.row].commentBody
        if thisComments[indexPath.row].imgFileName == "NO IMG" {
            drawCellWithoutImg(dummyCell)
        } else {
            drawCellWithImg(dummyCell, indexPath)
        }
        dummyCell.layoutIfNeeded()
        let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
        return estimateSize.height
    }
    func drawVendor(_ cell: CommentCell, _ indexPath: IndexPath) {
        cell.addSubview(cell.faceImgView)
        cell.faceImgView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cell.faceImgView.leftAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leftAnchor).isActive = true
        cell.addSubview(cell.vendorLabel)
        cell.vendorLabel.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor).isActive = true
        cell.vendorLabel.leftAnchor.constraint(equalTo: cell.faceImgView.rightAnchor, constant: 10).isActive = true
        
        let fullVendorString = thisComments[indexPath.row].vendor
        var splitedVendorString = fullVendorString.components(separatedBy: "-")
        
        cell.vendorLabel.text = splitedVendorString[0]
    }
    func drawCellWithImg(_ cell: CommentCell, _ indexPath: IndexPath) {
        //파이어베이스 렉 때문에 잠시동안만 이미지 다운로드를 하지 않는다. 대신 대체 이미지 사용.
        downloadImgToCell(cell, indexPath)
        cell.addSubview(cell.imgView)
        cell.imgView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        cell.imgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cell.imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cell.imgView.layer.borderWidth = 1
        cell.imgView.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgView.layer.cornerRadius = 10
        cell.imgView.clipsToBounds = true
        cell.addSubview(cell.commentBodyLabel)
        cell.commentBodyLabel.topAnchor.constraint(equalTo: cell.faceImgView.bottomAnchor, constant: 10).isActive = true
        cell.commentBodyLabel.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.commentBodyLabel.bottomAnchor.constraint(equalTo: cell.imgView.topAnchor, constant: -10).isActive = true
        
        cell.imgView.isUserInteractionEnabled = true
        cell.imgView.addMakeBigFunction()
        
        
    }
    func drawCellWithoutImg(_ cell: CommentCell) {
        cell.addSubview(cell.commentBodyLabel)
        cell.commentBodyLabel.topAnchor.constraint(equalTo: cell.faceImgView.bottomAnchor, constant: 10).isActive = true
        cell.commentBodyLabel.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.commentBodyLabel.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    func downloadImgToCell(_ cell: CommentCell, _ indexPath: IndexPath) {
        cell.imgView.kf.indicatorType = .activity
        if DBUtil.shared.loadImgFromCache(thisComments[indexPath.row].imgFileName) == nil {
            DispatchQueue.main.async {
                cell.imgView.kf.indicator?.startAnimatingView()
            }
            DBUtil.shared.loadCommentImgsFromStorage(thisComments[indexPath.row].imgFileName) { url in
                let resource = ImageResource(downloadURL: url, cacheKey: self.thisComments[indexPath.row].imgFileName)
                DispatchQueue.main.async {
                    cell.imgView.kf.setImage(with: resource)
                    cell.imgView.kf.indicator?.stopAnimatingView()
                }
            }
        } else {
            cell.imgView.image = DBUtil.shared.loadImgFromCache(thisComments[indexPath.row].imgFileName)
        }
    }
    func drawVerticalDots(_ cell: CommentCell, _ indexPath: IndexPath) {
        cell.contentView.addSubview(cell.verticalDotButton)
        cell.verticalDotButton.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cell.verticalDotButton.rightAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.rightAnchor,constant: -5).isActive = true
    }
    func drawTimeLabel(_ cell: CommentCell, _ indexPath: IndexPath) {
        cell.addSubview(cell.timeLabel)
        cell.timeLabel.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cell.timeLabel.rightAnchor.constraint(equalTo: cell.verticalDotButton.leftAnchor, constant: -5).isActive = true
        let now = Int(NSDate().timeIntervalSince1970)
        var elapsedTime = (now - thisComments[indexPath.row].timeStamp) / 60
        if elapsedTime <= 0 {
            cell.timeLabel.text = "방금 전"
        } else if elapsedTime < 60 {
            cell.timeLabel.text = "\(elapsedTime)분 전"
        } else if elapsedTime < 1440 {
            elapsedTime = elapsedTime / 60
            cell.timeLabel.text = "\(elapsedTime)시간 전"
        } else if elapsedTime < 10080 {
            elapsedTime = elapsedTime / (60 * 24)
            cell.timeLabel.text = "\(elapsedTime)일 전"
        } else if elapsedTime < 43200 {
            elapsedTime = elapsedTime / (60 * 24 * 7)
            cell.timeLabel.text = "\(elapsedTime)주 전"
        } else {
            elapsedTime = elapsedTime / (60 * 24 * 30)
            cell.timeLabel.text = "\(elapsedTime)달 전"
        }
    }
    func drawBorderLine(_ cell: CommentCell, _ indexPath: IndexPath) {
        cell.addSubview(cell.borderLineImgView)
        cell.borderLineImgView.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        cell.borderLineImgView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    @objc func handleDotTap() {
        
    }
}
extension ChatDetailController: CommentDeleteDelegate {
    func dotTap(indexPath: IndexPath) {
        if thisComments[indexPath.row].vendor == UIDevice.current.identifierForVendor?.uuidString {
            
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
        commentTextView.text = thisComments[indexPath.row].commentBody
        if thisComments[indexPath.row].imgFileName != "NO IMG" {
            self.isEditTargetCommentHasIMg = true
            redrawViewsWithImg()
            self.imgView.image = DBUtil.shared.loadImgFromCache(thisComments[indexPath.row].imgFileName)
        }
    }
    func editCancel(_ cell: CommentCell) {
               self.isCommentEditing = false
        self.isEditTargetCommentHasIMg = false
        self.commentTextView.text = ""
        
    }
    func delete(indexPath: IndexPath) {
        DB_COMMENTS.child(thisComments[indexPath.row].uid).removeValue()
        STORAGE_COMMENT_IMGS.child(thisComments[indexPath.row].imgFileName).delete { error in
            print("이미지 삭제 에러 -\(error)")
        }
        thisComments.remove(at: indexPath.row)
        commentCountDown()
        collectionView.reloadData()
    }
    func commentCountDown() {
        let commentCount = thisComments.count
        DB_CHATS.child(self.chat!.uid).updateChildValues(["commentCount": commentCount])
    }
    
}

