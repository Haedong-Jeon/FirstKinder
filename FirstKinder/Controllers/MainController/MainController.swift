//
//  MainController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
let cellReuseIdentifier = "reuseIdentifier"

class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    var nowShowingKinders = [Kinder]() {
        didSet {
            collectionView.reloadData()
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if !searchText.isEmpty {
            nowShowingKinders = kinders.filter({$0.craddr.contains(searchText) || $0.title.contains(searchText)})
        } else {
            nowShowingKinders = kinders
        }
    }
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        nowShowingKinders = kinders
        configureUI()
        configureSearch()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(KinderCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    }
    func configureUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
    func configureSearch() {
        self.navigationController?.navigationBar.isHidden = false
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "어린이집 이름, 혹은 지역 검색"
        navigationItem.searchController = searchController
        navigationItem.hidesBackButton = true
        definesPresentationContext = false
    }
}
