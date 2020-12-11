//
//  CommentCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

protocol CommentDeleteDelegate: class {
    func delete(indexPath: IndexPath)
}
class CommentCell: UICollectionViewCell {
    let cellDeleteButton = UIButton(type: .system)
    var deleteDelegate: CommentDeleteDelegate?
    var thisIdxPath: IndexPath?
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
    var chatBodyLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var imgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
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
        cellDeleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        addSubview(cellDeleteButton)
        cellDeleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        cellDeleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    @objc func handleDelete() {
        guard let deleteIndexPath = self.thisIdxPath else { return }
        deleteDelegate?.delete(indexPath: deleteIndexPath)
    }
    @objc func handleComment() {
        
    }
}
