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
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowChats.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 200)
    }
}
