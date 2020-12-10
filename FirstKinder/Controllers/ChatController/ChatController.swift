//
//  ParentsChatController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

let chatCellReuseIdentifier = "chat cell reuse"
class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var nowChats: [Chat] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var blockedUsers = [String]()
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
        guard let blockedUsers = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else {
            return
        }
        self.blockedUsers = blockedUsers
        self.blockedUsers.forEach({print("blocked user: \($0)")})
        chatReload()
    }
    @objc func handleRefresh() {
        chatReload()
    }
    func removeBlockedUser() {
        nowChats.removeAll()
        for chat in chats {
            var blocked = false
            for blockedVendor in self.blockedUsers {
                if chat.vendor == blockedVendor {
                    blocked = true
                    break
                }
            }
            if !blocked {
                nowChats.append(chat)
            }
        }
    }
    func chatReload() {
        collectionView.refreshControl?.beginRefreshing()
        if self.blockedUsers.isEmpty {
            nowChats = chats
        } else {
            removeBlockedUser()
        }
        collectionView.refreshControl?.endRefreshing()
    }
}
