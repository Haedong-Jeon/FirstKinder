//
//  MainController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
let cellReuseIdentifier = "reuseIdentifier"

class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(KinderCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
}
