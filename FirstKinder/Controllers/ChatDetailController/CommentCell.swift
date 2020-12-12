//
//  CommentCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

protocol CommentDeleteDelegate: class {
    func delete(indexPath: IndexPath)
    func edit(indexPath: IndexPath)
}
class CommentCell: UICollectionViewCell {
    let cellDeleteButton = UIButton(type: .system)
    let editButton = UIButton(type: .system)
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
    var commentBodyLabel: UILabel = {
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
        cellDeleteButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        cellDeleteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        cellDeleteButton.layer.cornerRadius = 5
        cellDeleteButton.setTitle("삭제", for: .normal)
        cellDeleteButton.setTitleColor(.white, for: .normal)
        cellDeleteButton.backgroundColor = .red
        cellDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        cellDeleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
        addSubview(cellDeleteButton)
        cellDeleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        cellDeleteButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    func addEditButton() {
        editButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        editButton.layer.cornerRadius = 5
        editButton.setTitle("수정", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.backgroundColor = .black
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        addSubview(editButton)
        editButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        editButton.rightAnchor.constraint(equalTo: cellDeleteButton.leftAnchor, constant: -10).isActive = true
    }
    @objc func handleDelete() {
        guard let deleteIndexPath = self.thisIdxPath else { return }
        deleteDelegate?.delete(indexPath: deleteIndexPath)
    }
    @objc func handleEdit() {
        guard let editIndexPath = self.thisIdxPath else { return }
        deleteDelegate?.edit(indexPath: editIndexPath)
    }
}
