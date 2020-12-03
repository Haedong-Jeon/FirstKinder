//
//  MyKinders.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit
import GoogleMobileAds
let cellReuseIdentifierInMyKinder = "reuseIdentifier"

class MyKindersController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var bannerView: GADBannerView!
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
        
        //시뮬레이터로 테스트할 때만 살릴 것
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerView(bannerView)
        
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
