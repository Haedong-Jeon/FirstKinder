//
//  BlockUserCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

class BlockUserCell: UICollectionViewCell {
    var blockReasonStickerLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 95).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "사유"
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
    var blockedUserVendorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .justified
        return label
    }()
    var blockedReasonLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .justified
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureUI() {
        addSubview(blockReasonStickerLabel)
        blockReasonStickerLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        blockReasonStickerLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        addSubview(faceImgView)
        faceImgView.topAnchor.constraint(equalTo: blockReasonStickerLabel.bottomAnchor).isActive = true
        faceImgView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        
        addSubview(blockedUserVendorLabel)
        blockedUserVendorLabel.topAnchor.constraint(equalTo: blockReasonStickerLabel.bottomAnchor).isActive = true
        blockedUserVendorLabel.leftAnchor.constraint(equalTo: faceImgView.rightAnchor, constant: 5).isActive = true
        blockedUserVendorLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        blockedUserVendorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(blockedReasonLabel)
        blockedReasonLabel.topAnchor.constraint(equalTo: blockReasonStickerLabel.bottomAnchor, constant: 10).isActive = true
        blockedReasonLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        blockedReasonLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        blockedReasonLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
