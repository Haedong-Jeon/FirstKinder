//
//  ChatDetailHelperForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

extension ChatDetailController {
    func configureUI() {
        view.backgroundColor = .white
        configureCollectionView()
    }
    func configureCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentCellReuseIdentifier)
        collectionView.register(ChatDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier )
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}
