//
//  MainController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import GoogleMobileAds
let cellReuseIdentifier = "reuseIdentifier"

class ListController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    var bannerView: GADBannerView!
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
        
        //시뮬레이터에서 테스트 할 때만 살릴 것
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerView(bannerView)
        
        drawCollectionView()
    }
    func addBannerView(_ bannerView: GADBannerView) {
        
        bannerView.adUnitID = "ca-app-pub-9114448172368235/7500496163"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        bannerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bannerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
