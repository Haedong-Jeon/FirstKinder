//
//  BlockedUserController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit
let reuseIdentifierForBlockUser = "cell reuse identifier for blocked users"

class BlockedUserController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var blockedUserList = [String]()
    var blockReasonList = [String]()
    var blockReasonCategoriesList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBlockedUsers()
        loadBlockedReasons()
        loadBlockReasonCategories()
        configureUI()
    }
    func loadBlockedUsers() {
        guard let _blockedUserList = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else { return }
        self.blockedUserList = _blockedUserList
    }
    func loadBlockedReasons() {
        guard let _blockReasonList = UserDefaults.standard.array(forKey: "blockedReasons") as? [String] else { return }
        self.blockReasonList = _blockReasonList
    }
    func loadBlockReasonCategories() {
        guard let _blockReasonCategoriesList = UserDefaults.standard.array(forKey: "blockedReasonCategories") as? [String] else { return }
        self.blockReasonCategoriesList = _blockReasonCategoriesList
    }
}
