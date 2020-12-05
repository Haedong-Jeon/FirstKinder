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
        
        //실제 아이폰으로 테스트 할 때
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }
}
