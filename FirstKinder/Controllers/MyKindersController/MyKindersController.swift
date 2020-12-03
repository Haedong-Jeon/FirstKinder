//
//  MyKinders.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit
let cellReuseIdentifierInMyKinder = "reuseIdentifier"

class MyKindersController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var kinders = [Kinder]() {
        didSet {
            collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        configureUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(KinderCell.self, forCellWithReuseIdentifier: cellReuseIdentifierInMyKinder)
        drawCollectionView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.kinders = myKinders
    }
    func configureUI() {
        self.navigationController?.navigationBar.topItem?.title = "관심 어린이집"
        view.backgroundColor = .white
    }
}
