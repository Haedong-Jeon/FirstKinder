//
//  ChatCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit
protocol CellDeleteDelegate: class {
    func delete(indexPath: IndexPath)
}
class ChatCell: UICollectionViewCell {
    let cellDeleteButton = UIButton(type: .system)
    let cellCommentButton = UIButton(type: .system)
    var deleteDelegate: CellDeleteDelegate?
    var thisIdxPath: IndexPath?
    var categoryLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    var timeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = .placeholderText
        return label
    }()
    var faceImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imgView.image = UIImage(systemName: "smiley")
        return imgView
    }()
    var vendorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()
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
    var commentCountLabel = UILabel()
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
        cellDeleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        addSubview(cellDeleteButton)
        cellDeleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        cellDeleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    func drawCommentCount() {
        addSubview(commentCountLabel)
        commentCountLabel.translatesAutoresizingMaskIntoConstraints = false
        commentCountLabel.leftAnchor.constraint(equalTo: cellCommentButton.rightAnchor, constant: 5).isActive = true
        commentCountLabel.centerYAnchor.constraint(equalTo: cellCommentButton.centerYAnchor).isActive = true
        commentCountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        commentCountLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        commentCountLabel.font = UIFont.systemFont(ofSize: 15)
        commentCountLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        commentCountLabel.text = "댓글 0"
    }
    
    func addCommentButton() {
        cellCommentButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        cellCommentButton.tintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        cellCommentButton.translatesAutoresizingMaskIntoConstraints = false
        cellCommentButton.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        addSubview(cellCommentButton)
        cellCommentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        cellCommentButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        drawCommentCount()
    }
    @objc func handleDelete() {
        guard let deleteIndexPath = self.thisIdxPath else { return }
        deleteDelegate?.delete(indexPath: deleteIndexPath)
    }
    @objc func handleComment() {
        
    }
}
