//
//  BlockUserHelperForCollectionViewDelegate.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

extension BlockedUserController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForBlockUser, for: indexPath) as? BlockUserCell else {
            return UICollectionViewCell()
        }
        let fullVendor = self.blockedUserList[indexPath.row]
        let blockedUserVendor = fullVendor.components(separatedBy: "-")
        cell.blockedUserVendorLabel.text = blockedUserVendor[0]
        cell.blockedReasonLabel.text = "상세 사유: " + self.blockReasonList[indexPath.row]
        cell.backgroundColor = .white
        
        if self.blockReasonCategoriesList[indexPath.row] == "불쾌한 게시물" {
            cell.blockReasonStickerLabel.backgroundColor = .systemPink
            cell.blockReasonStickerLabel.text = "불쾌한 게시물"
        } else if self.blockReasonCategoriesList[indexPath.row] == "부적절한 광고" {
            cell.blockReasonStickerLabel.backgroundColor = .black
            cell.blockReasonStickerLabel.text = "부적절한 광고"
        } else if self.blockReasonCategoriesList[indexPath.row] == "기타" {
            cell.blockReasonStickerLabel.backgroundColor = .systemBlue
            cell.blockReasonStickerLabel.text = "기타 사유"
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.blockedUserList.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let askAlert = UIAlertController(title: "차단 해제", message: "차단 해제할까요?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default) { (ACTION) in
            self.eraseLocalBlockedUser(idx: indexPath)
            self.eraseLocalBlockedReason(idx: indexPath)
            self.eraseLocalBlockReasonCategory(idx: indexPath)
            
            self.loadBlockedUsers()
            self.loadBlockedReasons()
            self.loadBlockReasonCategories()
            self.collectionView.reloadData()

        }
        let cancelButton = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        askAlert.addAction(okButton)
        askAlert.addAction(cancelButton)
        
        self.present(askAlert, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 100)
    }
    func eraseLocalBlockedUser(idx: IndexPath) {
        guard let blocks = UserDefaults.standard.array(forKey: "blockedUsers") as? [String] else {
            return
        }
        blockedUserVendors = blocks
        blockedUserVendors.remove(at: idx.row)
        UserDefaults.standard.setValue(blockedUserVendors, forKey: "blockedUsers")
    }
    func eraseLocalBlockedReason(idx: IndexPath) {
        guard let reasons = UserDefaults.standard.array(forKey: "blockedReasons") as? [String] else {
            return
        }
        blockedUserReasons = reasons
        blockedUserReasons.remove(at: idx.row)
        UserDefaults.standard.setValue(blockedUserReasons, forKey: "blockedReasons")
    }
    func eraseLocalBlockReasonCategory(idx: IndexPath) {
        guard let reasonCategories = UserDefaults.standard.array(forKey: "blockedReasonCategories") as? [String] else {
            return
        }
        blockedReasonCategories = reasonCategories
        blockedReasonCategories.remove(at: idx.row)
        UserDefaults.standard.setValue(blockedReasonCategories, forKey: "blockedReasonCategories")
    }
}
