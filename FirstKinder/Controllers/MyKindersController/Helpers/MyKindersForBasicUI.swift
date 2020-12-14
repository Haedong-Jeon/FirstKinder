//
//  MyKindersForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit

extension MyKindersController {
    func drawCollectionView() {
        if self.kinders.isEmpty {
            collectionView.backgroundColor = .lightGray
        } else {
            collectionView.backgroundColor = .white
        }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

    }
}
