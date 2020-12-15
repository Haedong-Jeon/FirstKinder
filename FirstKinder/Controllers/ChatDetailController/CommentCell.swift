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
    func dotTap(indexPath: IndexPath)
}
class CommentCell: UICollectionViewCell {
    var deleteDelegate: CommentDeleteDelegate?
    var thisIdxPath: IndexPath?
    var verticalDotButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return button
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
    var downRightArrow: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = #imageLiteral(resourceName: "right-arrow")
        imgView.sizeToFit()
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
    func addFunctionToVerticalDots() {
        verticalDotButton.addTarget(self, action: #selector(handleDotTap), for: .touchUpInside)
    }
    @objc func handleDelete() {
        guard let deleteIndexPath = self.thisIdxPath else { return }
        deleteDelegate?.delete(indexPath: deleteIndexPath)
    }
    @objc func handleEdit() {
        guard let editIndexPath = self.thisIdxPath else { return }
        deleteDelegate?.edit(indexPath: editIndexPath)
    }
    @objc func handleDotTap() {
        print("dot taped!")
        guard let selectedIndexPath = self.thisIdxPath else { return }
        deleteDelegate?.dotTap(indexPath: selectedIndexPath)
    }
}
