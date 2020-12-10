//
//  HelperForChatCollectionView.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
import Kingfisher

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: chatCellReuseIdentifier, for: indexPath) as? ChatCell else {
            return UICollectionViewCell()
        }
        cell.deleteDelegate = self
        cell.thisIdxPath = indexPath
        cell.imgView.removeFromSuperview()
        cell.chatBodyTextView.removeFromSuperview()
        drawVendor(cell, indexPath)
        drawCategoryLabel(cell, indexPath)
        drawTimeLabel(cell, indexPath)
        cell.chatBodyTextView.text = nowChats[indexPath.row].chatBody
        drawBorderLine(cell)
        if nowChats[indexPath.row].imgFileName != "NO IMG" {
            drawCellWithImg(cell, indexPath)
        } else {
            drawCellWithoutImg(cell)
        }
        addDeleteButtonToCell(cell, indexPath)
        cell.addCommentButton()
        cell.backgroundColor = .white
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowChats.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = getEstimatedHeightFromDummyCell(indexPath)
        return CGSize(width: collectionView.frame.width - 10, height: height)
    }
    func getEstimatedHeightFromDummyCell(_ indexPath: IndexPath) -> CGFloat{
        let width = view.frame.width - 10
        let estimatedHeight: CGFloat = 800.0
        let dummyCell = ChatCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
        drawVendor(dummyCell, indexPath)
        drawCategoryLabel(dummyCell, indexPath)
        drawBorderLine(dummyCell)
        dummyCell.chatBodyTextView.text = nowChats[indexPath.row].chatBody
        if nowChats[indexPath.row].imgFileName == "NO IMG" {
            drawCellWithoutImg(dummyCell)
        } else {
            drawCellWithImg(dummyCell, indexPath)
        }
        dummyCell.layoutIfNeeded()
        let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
        return estimateSize.height
    }
    func configureCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: chatCellReuseIdentifier)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    func drawBorderLine(_ cell: ChatCell) {
        cell.addSubview(cell.borderLineImgView)
        cell.borderLineImgView.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        cell.borderLineImgView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -30).isActive = true
    }
    
    func drawCellWithImg(_ cell: ChatCell, _ indexPath: IndexPath) {
        //파이어베이스 렉 때문에 잠시동안만 이미지 다운로드를 하지 않는다. 대신 대체 이미지 사용.
        downloadImgToCell(cell, indexPath)
        cell.addSubview(cell.imgView)
        cell.imgView.bottomAnchor.constraint(equalTo: cell.borderLineImgView.topAnchor, constant: -10).isActive = true
        cell.imgView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 10).isActive = true
        cell.imgView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -10).isActive = true
        cell.imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        cell.imgView.layer.borderWidth = 1
        cell.imgView.layer.borderColor = UIColor.lightGray.cgColor
        cell.imgView.layer.cornerRadius = 10
        cell.imgView.clipsToBounds = true
        cell.addSubview(cell.chatBodyTextView)
        cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.categoryLabel.bottomAnchor).isActive = true
        cell.chatBodyTextView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.chatBodyTextView.bottomAnchor.constraint(equalTo: cell.imgView.topAnchor, constant: -10).isActive = true
    }
    func drawCellWithoutImg(_ cell: ChatCell) {
        cell.addSubview(cell.chatBodyTextView)
        cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.categoryLabel.bottomAnchor).isActive = true
        cell.chatBodyTextView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.chatBodyTextView.bottomAnchor.constraint(equalTo: cell.borderLineImgView.topAnchor).isActive = true
    }
    
    func addDeleteButtonToCell(_ cell: ChatCell, _ indexPath: IndexPath) {
        cell.addDeleteButton()
        cell.cellDeleteButton.isUserInteractionEnabled = false
        cell.cellDeleteButton.isHidden = true
        if nowChats[indexPath.row].vendor == UIDevice.current.identifierForVendor?.uuidString {
            cell.cellDeleteButton.isUserInteractionEnabled = true
            cell.cellDeleteButton.isHidden = false
        }
    }
    func downloadImgToCell(_ cell: ChatCell, _ indexPath: IndexPath) {
        cell.imgView.kf.indicatorType = .activity
        if DBUtil.shared.loadImgFromCache(nowChats[indexPath.row].imgFileName) == nil {
            cell.imgView.kf.indicator?.startAnimatingView()
            DBUtil.shared.loadChatImgsFromStorage(nowChats[indexPath.row].imgFileName) { url in
                let resource = ImageResource(downloadURL: url, cacheKey: self.nowChats[indexPath.row].imgFileName)
                cell.imgView.kf.setImage(with: resource)
                cell.imgView.kf.indicator?.stopAnimatingView()
            }
        } else {
            cell.imgView.image = DBUtil.shared.loadImgFromCache(nowChats[indexPath.row].imgFileName)
        }
    }
    func drawVendor(_ cell: ChatCell, _ indexPath: IndexPath) {
        cell.addSubview(cell.faceImgView)
        cell.faceImgView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cell.faceImgView.leftAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        cell.addSubview(cell.vendorLabel)
        cell.vendorLabel.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor).isActive = true
        cell.vendorLabel.leftAnchor.constraint(equalTo: cell.faceImgView.rightAnchor).isActive = true
        
        let fullVendorString = nowChats[indexPath.row].vendor
        var splitedVendorString = fullVendorString.components(separatedBy: "-")
        
        cell.vendorLabel.text = splitedVendorString[0]
    }
    func drawTimeLabel(_ cell: ChatCell, _ indexPath: IndexPath) {
        cell.addSubview(cell.timeLabel)
        cell.timeLabel.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cell.timeLabel.rightAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        let now = Int(NSDate().timeIntervalSince1970)
        var elapsedTime = (now - nowChats[indexPath.row].timeStamp) / 60
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
    func drawCategoryLabel(_ cell: ChatCell, _ indexPath: IndexPath) {
        cell.addSubview(cell.categoryLabel)
        cell.categoryLabel.topAnchor.constraint(equalTo: cell.faceImgView.bottomAnchor).isActive = true
        cell.categoryLabel.leftAnchor.constraint(equalTo: cell.faceImgView.leftAnchor).isActive = true
        
        cell.categoryLabel.backgroundColor = .systemIndigo
        cell.categoryLabel.textColor = .white
        cell.categoryLabel.textAlignment = .center
        cell.categoryLabel.text = "어린이집"
    }
    
}

extension ChatController: CellDeleteDelegate {
    func delete(indexPath: IndexPath) {
        DB_CHATS.child(nowChats[indexPath.row].uid).removeValue()
        STORAGE_USER_UPLOAD_IMGS.child(nowChats[indexPath.row].uid).delete { error in
            print("이미지 삭제 에러 -\(error)")
        }
        nowChats.remove(at: indexPath.row)
        
        collectionView.reloadData()
    }
}
