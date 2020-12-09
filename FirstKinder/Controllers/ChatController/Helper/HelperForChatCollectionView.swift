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
        cell.imgView.removeFromSuperview()
        cell.chatBodyTextView.removeFromSuperview()
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
        if nowChats[indexPath.row].imgFileName != "NO IMG" {
            return CGSize(width: collectionView.frame.width - 10, height: 350)
        }
        return CGSize(width: collectionView.frame.width - 10, height: 100)
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
        cell.addSubview(cell.chatBodyTextView)
        cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor).isActive = true
        cell.chatBodyTextView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.chatBodyTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        cell.addSubview(cell.imgView)
        cell.imgView.topAnchor.constraint(equalTo: cell.chatBodyTextView.bottomAnchor).isActive = true
        cell.imgView.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 10).isActive = true
        cell.imgView.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -10).isActive = true
        cell.imgView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func drawCellWithoutImg(_ cell: ChatCell) {
        cell.addSubview(cell.chatBodyTextView)
        cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor).isActive = true
        cell.chatBodyTextView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
        cell.chatBodyTextView.bottomAnchor.constraint(equalTo: cell.borderLineImgView.topAnchor).isActive = true
    }
    
    func addDeleteButtonToCell(_ cell: ChatCell, _ indexPath: IndexPath) {
        cell.addDeleteButton()
        cell.cellDeleteButton.isUserInteractionEnabled = false
        cell.cellDeleteButton.isHidden = true
        myChatsSavedByUid.forEach({
            if $0 == nowChats[indexPath.row].uid {
                cell.cellDeleteButton.isUserInteractionEnabled = true
                cell.cellDeleteButton.isHidden = false
                cell.thisIdx = indexPath.row
                cell.chatController = self
            }
        })
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
}
