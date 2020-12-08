//
//  ChatCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

class ChatCell: UICollectionViewCell {
    let cellDeleteButton = UIButton(type: .system)

    var chatBodyTextView: UITextView = {
        var textView = UITextView()
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var imgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI() {
        addSubview(chatBodyTextView)
        addSubview(imgView)
        
        chatBodyTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        chatBodyTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        chatBodyTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        imgView.topAnchor.constraint(equalTo: chatBodyTextView.bottomAnchor).isActive = true
        imgView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        cellDeleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        cellDeleteButton.tintColor = .lightGray
        cellDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        cellDeleteButton.sizeToFit()
        cellDeleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        addSubview(cellDeleteButton)
        cellDeleteButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cellDeleteButton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    @objc func handleDelete() {
        
    }
}
