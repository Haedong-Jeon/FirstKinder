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
        if nowChats[indexPath.row].imgFileName != "NO IMG" {
            //이미지 있다.
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
            cell.addSubview(cell.chatBodyTextView)
            cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor).isActive = true
            cell.chatBodyTextView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
            cell.chatBodyTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            cell.addSubview(cell.imgView)
            cell.imgView.topAnchor.constraint(equalTo: cell.chatBodyTextView.bottomAnchor).isActive = true
            cell.imgView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
            cell.imgView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            //이미지 없다.
            cell.addSubview(cell.chatBodyTextView)
            cell.chatBodyTextView.topAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.topAnchor).isActive = true
            cell.chatBodyTextView.widthAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.widthAnchor).isActive = true
            cell.chatBodyTextView.bottomAnchor.constraint(equalTo: cell.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
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
        cell.addDeleteButton()
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowChats.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if nowChats[indexPath.row].imgFileName != "NO IMG" {
            return CGSize(width: collectionView.frame.width - 10, height: 300)
        }
        return CGSize(width: collectionView.frame.width - 10, height: 100)
    }
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: chatCellReuseIdentifier)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
}
