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
    let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        configureUI()
        configureCollectionView()
        configureIndicator()
        
        indicator.startAnimating()
        
        DBUtil.shared.loadChatTexts { loadedChats in
            chats = loadedChats.sorted(by: {$0.timeStamp > $1.timeStamp})
            self.chatReload()
            self.indicator.stopAnimating()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @objc func handleRefresh() {
        chatReload()
    }
    func chatReload() {
        collectionView.refreshControl?.beginRefreshing()
        nowChats = chats
        collectionView.reloadData()
        collectionView.refreshControl?.endRefreshing()
    }
 
}
