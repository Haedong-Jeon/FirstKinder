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
    var floatingButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.setTitle("+", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleChatTap), for: .touchUpInside)
        return button
    }()
    var isShowingMyChats = false
    var blockedUsers = [String]()
    var blockedReasons = [String]()
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
        guard let blockedReasons = UserDefaults.standard.array(forKey: "blockedReasons") as? [String] else {
            return
        }
        self.blockedReasons = blockedReasons
        self.blockedReasons.forEach({print("blocked reason: \($0)")})
        chatReload()
    }
    @objc func handleRefresh() {
        chatReload()
    }
    func loadChatWithoutBlockedUsers() {
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
            loadChatWithoutBlockedUsers()
        }
        collectionView.refreshControl?.endRefreshing()
    }
}
