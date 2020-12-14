//
//  MainController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import ANActivityIndicator
let cellReuseIdentifier = "reuseIdentifier"

class ListController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    var showKindersRangeStart = 0
    var showKindersRangeEnd = 10
    var scrollChecker = false
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
        drawCollectionView()
        
    }
}
