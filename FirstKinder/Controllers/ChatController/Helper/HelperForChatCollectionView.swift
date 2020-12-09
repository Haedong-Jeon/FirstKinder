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
        addVendor(cell, indexPath)
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
        let width = view.frame.width - 10
        let estimatedHeight: CGFloat = 500.0
        let dummyCell = ChatCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
        addVendor(dummyCell, indexPath)
        drawBorderLine(dummyCell)
        dummyCell.chatBodyTextView.text = nowChats[indexPath.row].chatBody
        if nowChats[indexPath.row].imgFileName == "NO IMG" {
            drawCellWithoutImg(dummyCell)
        } else {
            drawCellWithImg(dummyCell, indexPath)
        }
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
        
        return CGSize(width: width, height: estimatedSize.height)
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
        downloadImgToCell(cell, indexPath)
        cell.addSubview(cell.imgView)
        cell.imgView.bottomAnchor.constraint(equalTo: cell.borderLineImgView.topAnchor, constant: -10).isActive = true
        cell.imgView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 10).isActive = true
        cell.imgView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -10).isActive = true
        cell.imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        cell.addSubview(cell.chatBodyTextView)
        cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.vendorLabel.bottomAnchor).isActive = true
        cell.chatBodyTextView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.chatBodyTextView.bottomAnchor.constraint(equalTo: cell.imgView.topAnchor, constant: 10).isActive = true
    }
    func drawCellWithoutImg(_ cell: ChatCell) {
        cell.addSubview(cell.chatBodyTextView)
        cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.vendorLabel.bottomAnchor).isActive = true
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
        cell.imgView.kf.indicator?.startAnimatingView()
        if DBUtil.shared.loadImgFromCache(nowChats[indexPath.row].imgFileName) == nil {
            DBUtil.shared.loadChatImgsFromStorage(nowChats[indexPath.row].imgFileName) { url in
                let resource = ImageResource(downloadURL: url, cacheKey: self.nowChats[indexPath.row].imgFileName)
                cell.imgView.kf.setImage(with: resource)
                cell.imgView.kf.indicator?.stopAnimatingView()
            }
        } else {
            cell.imgView.image = DBUtil.shared.loadImgFromCache(nowChats[indexPath.row].imgFileName)
            cell.imgView.kf.indicator?.stopAnimatingView()
        }
    }
    func addVendor(_ cell: ChatCell, _ indexPath: IndexPath) {
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
