//
//  ChatDetailHelperForCollectionViewDelegate.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

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
        3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellReuseIdentifier, for: indexPath) as? CommentCell else {
            return UICollectionViewCell()
        }
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
}
