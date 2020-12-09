//
//  ChatCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

class ChatCell: UICollectionViewCell {
    let cellDeleteButton = UIButton(type: .system)
    var thisIdx = 0
    var chatController = ChatController()
    var chatBodyTextView: UITextView = {
        var textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var imgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    var borderLineImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293010831, alpha: 1)
        imgView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return imgView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addDeleteButton() {
        cellDeleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        cellDeleteButton.tintColor = .black
        cellDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        cellDeleteButton.sizeToFit()
        cellDeleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        addSubview(cellDeleteButton)
        cellDeleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        cellDeleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    @objc func handleDelete() {
        let deleteTarget = chatController.nowChats[self.thisIdx]
        chatController.nowChats.remove(at: self.thisIdx)
        chatController.collectionView.reloadData()
        
        DB_CHATS.child(deleteTarget.uid).removeValue()
        STORAGE_USER_UPLOAD_IMGS.child(deleteTarget.uid).delete { error in
            print("이미지 삭제 에러 -\(error)")
        }
        
        guard let deleteIdxForLocal = myChatsSavedByUid.firstIndex(of: deleteTarget.uid) else { return }
        myChatsSavedByUid.remove(at: deleteIdxForLocal)
    }
    
}

