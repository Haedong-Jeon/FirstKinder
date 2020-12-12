//
//  ChatCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

class ChatCell: UICollectionViewCell {
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
    func drawCommentCount(_ count: Int) {
        addSubview(commentCountLabel)
        commentCountLabel.translatesAutoresizingMaskIntoConstraints = false
        commentCountLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        commentCountLabel.topAnchor.constraint(equalTo: borderLineImgView.bottomAnchor).isActive = true
        commentCountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        commentCountLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        commentCountLabel.font = UIFont.systemFont(ofSize: 15)
        commentCountLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        commentCountLabel.text = "댓글 \(count)"
    }
}
