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
        header.backgroundColor = .white
        header.setUp()
        if self.chat?.imgFileName == "NO IMG" {
            header.configureUIWithoutImg()
        } else {
            header.configureUIWithImg()
        }
        return header
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thisComments.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getEstimatedHeightFromDummyCell(indexPath)
        return CGSize(width: collectionView.frame.width - 10, height: height)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellReuseIdentifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
        cell.addDeleteButton()
        activateDeleteButtonIfUserComment(cell, indexPath)
        cell.deleteDelegate = self
        cell.thisIdxPath = indexPath
        cell.imgView.removeFromSuperview()
        cell.chatBodyLabel.removeFromSuperview()
        drawVendor(cell, indexPath)
        drawTimeLabel(cell, indexPath)
        cell.chatBodyLabel.text = thisComments[indexPath.row].commentBody
        if thisComments[indexPath.row].imgFileName != "NO IMG" {
            drawCellWithImg(cell, indexPath)
        } else {
            drawCellWithoutImg(cell)
        }
        
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width - 10, height: getEstimatedHeightByDummyHeader())
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
        dummyCell.chatBodyLabel.text = thisComments[indexPath.row].commentBody
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
        cell.vendorLabel.leftAnchor.constraint(equalTo: cell.faceImgView.rightAnchor).isActive = true
        
        let fullVendorString = thisComments[indexPath.row].vendor
        var splitedVendorString = fullVendorString.components(separatedBy: "-")
        
        cell.vendorLabel.text = splitedVendorString[0]
    }
    func drawCellWithImg(_ cell: CommentCell, _ indexPath: IndexPath) {
        //파이어베이스 렉 때문에 잠시동안만 이미지 다운로드를 하지 않는다. 대신 대체 이미지 사용.
        downloadImgToCell(cell, indexPath)
        cell.addSubview(cell.imgView)
        cell.imgView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor, constant: -35).isActive = true
        cell.imgView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 10).isActive = true
        cell.imgView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -10).isActive = true
        cell.imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        cell.imgView.layer.borderWidth = 1
        cell.imgView.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgView.layer.cornerRadius = 10
        cell.imgView.clipsToBounds = true
        cell.addSubview(cell.chatBodyLabel)
        cell.chatBodyLabel.topAnchor.constraint(equalTo: cell.faceImgView.bottomAnchor, constant: 10).isActive = true
        cell.chatBodyLabel.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.chatBodyLabel.bottomAnchor.constraint(equalTo: cell.imgView.topAnchor, constant: -10).isActive = true
    }
    func drawCellWithoutImg(_ cell: CommentCell) {
        cell.addSubview(cell.chatBodyLabel)
        cell.chatBodyLabel.topAnchor.constraint(equalTo: cell.faceImgView.bottomAnchor, constant: 10).isActive = true
        cell.chatBodyLabel.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.chatBodyLabel.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor, constant: -35).isActive = true
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
    func drawTimeLabel(_ cell: CommentCell, _ indexPath: IndexPath) {
        cell.addSubview(cell.timeLabel)
        cell.timeLabel.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cell.timeLabel.rightAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
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
    func activateDeleteButtonIfUserComment(_ cell: CommentCell, _ indexPath: IndexPath) {
        cell.cellDeleteButton.isUserInteractionEnabled = false
        cell.cellDeleteButton.isHidden = true
        if thisComments[indexPath.row].vendor == UIDevice.current.identifierForVendor?.uuidString {
            cell.cellDeleteButton.isUserInteractionEnabled = true
            cell.cellDeleteButton.isHidden = false
        }
    }
}
extension ChatDetailController: CommentDeleteDelegate {
    func delete(indexPath: IndexPath) {
        DB_COMMENTS.child(thisComments[indexPath.row].uid).removeValue()
        STORAGE_COMMENT_IMGS.child(thisComments[indexPath.row].imgFileName).delete { error in
            print("이미지 삭제 에러 -\(error)")
        }
        thisComments.remove(at: indexPath.row)
        collectionView.reloadData()
    }
}
