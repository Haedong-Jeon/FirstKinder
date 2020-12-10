//
//  BlockedUserHelperForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

extension BlockedUserController {
    func configureUI() {
        view.backgroundColor = .white
        configureCollectionView()
        configureNavBar()
    }
    func configureCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BlockUserCell.self, forCellWithReuseIdentifier: reuseIdentifierForBlockUser)
    }
    func configureNavBar() {
        self.navigationController?.navigationBar.topItem?.title = "차단 목록"
    }
}
