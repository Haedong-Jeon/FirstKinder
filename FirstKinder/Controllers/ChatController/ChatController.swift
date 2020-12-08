//
//  ParentsChatController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
let chatCellReuseIdentifier = "chat cell reuse"
class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var nowChats = [Chat]()
    let refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        nowChats = chats
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: chatCellReuseIdentifier)
        collectionView.backgroundColor = .lightGray
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @objc func handleRefresh() {
        chatReload()
    }
    @objc func handleDeleteCell() {
        
    }
    func chatReload() {
        collectionView.refreshControl?.beginRefreshing()
        nowChats = chats
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
}
