//
//  MainHelperForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit

extension MainController {
    func drawCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bannerView.topAnchor).isActive = true
    }
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "어린이집 목록"
    }
    func configureSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "어린이집 이름, 혹은 지역 검색"
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        definesPresentationContext = false
    }
}
