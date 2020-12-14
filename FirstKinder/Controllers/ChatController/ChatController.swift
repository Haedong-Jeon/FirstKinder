//
//  ParentsChatController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
import ANActivityIndicator

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
        button.backgroundColor = #colorLiteral(red: 0.6369027091, green: 0.5376098795, blue: 1, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleChatTap), for: .touchUpInside)
        return button
    }()
    var isShowingMyChats = false
    var blockedUsers = [String]()
    var blockedReasons = [String]()
    var blockReasonCategories = [String]()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        configureUI()
        configureCollectionView()
        
        let indicator = ANActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30), animationType: .ballPulse, color: .black, padding: .none)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        indicator.startAnimating()
        
        DBUtil.shared.loadChatTexts { loadedChats in
            //1. 최신 게시글이 위로 올라간다.
            //2. 신고 당한 횟수가 5회 이하인 게시글만 표시한다.
            chats = loadedChats
                        .sorted(by: {$0.timeStamp > $1.timeStamp})
                        .filter({$0.reportCount < 5})
            
            self.chatReload()
            indicator.stopAnimating()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavBar()
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
        
        guard let reasonCategories = UserDefaults.standard.array(forKey: "blockedReasonCategories") as? [String] else {
            return
        }
        self.blockReasonCategories = reasonCategories
        self.blockReasonCategories.forEach({print("blocked categories: \($0)")})
        
        chatReload()
    }
    override func viewWillDisappear(_ animated: Bool) {
        isShowingMyChats = false
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
