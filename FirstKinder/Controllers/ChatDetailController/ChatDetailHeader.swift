//
//  ChatDetailHeader.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit
import Kingfisher

class ChatDetailHeader: UICollectionReusableView {
    var chat: Chat?
    lazy var categoryLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    lazy var timeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = .placeholderText
        return label
    }()
    lazy var faceImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        imgView.image = UIImage(systemName: "smiley")
        return imgView
    }()
    lazy var vendorLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return label
    }()
    lazy var chatBodyLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var imgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    lazy var borderLineImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293010831, alpha: 1)
        imgView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return imgView
    }()
    lazy var commentCountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "댓글 0"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUp() {
        setVendor()
        setTime()
        categoryLabel.text = chat?.category
        chatBodyLabel.text = chat?.chatBody
        drawBorderLine()
        drawTime()
        drawVendor()
        drawCategoryLabel()
        drawCommentCountLabel()
    }
    func setTime() {
        let now = Int(NSDate().timeIntervalSince1970)
        var elapsedTime = (now - chat!.timeStamp) / 60
        if elapsedTime <= 0 {
            timeLabel.text = "방금 전"
        } else if elapsedTime < 60 {
            timeLabel.text = "\(elapsedTime)분 전"
        } else if elapsedTime < 1440 {
            elapsedTime = elapsedTime / 60
            timeLabel.text = "\(elapsedTime)시간 전"
        } else if elapsedTime < 10080 {
            elapsedTime = elapsedTime / (60 * 24)
            timeLabel.text = "\(elapsedTime)일 전"
        } else if elapsedTime < 43200 {
            elapsedTime = elapsedTime / (60 * 24 * 7)
            timeLabel.text = "\(elapsedTime)주 전"
        } else {
            elapsedTime = elapsedTime / (60 * 24 * 30)
            timeLabel.text = "\(elapsedTime)달 전"
        }
    }
    func setVendor() {
        let fullVendorString = chat!.vendor
        let splitedVendorString = fullVendorString.components(separatedBy: "-")
        vendorLabel.text = splitedVendorString[0]
    }
    func configureUIWithImg() {
        downloadImg(imgFileName: chat!.imgFileName)
        addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        imgView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imgView.bottomAnchor.constraint(equalTo: commentCountLabel.topAnchor, constant: -10).isActive = true

        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        
        addSubview(chatBodyLabel)
        chatBodyLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10).isActive = true
        chatBodyLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        chatBodyLabel.bottomAnchor.constraint(equalTo: imgView.topAnchor, constant: -10).isActive = true
    }
    func configureUIWithoutImg() {
        addSubview(chatBodyLabel)
        chatBodyLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10).isActive = true
        chatBodyLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        chatBodyLabel.bottomAnchor.constraint(equalTo: commentCountLabel.topAnchor, constant: -10).isActive = true
    }
    func drawCategoryLabel() {
        addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: faceImgView.bottomAnchor).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: faceImgView.leftAnchor).isActive = true
        
        if chat?.category == "어린이집" {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            categoryLabel.textColor = .white
            categoryLabel.textAlignment = .center
            categoryLabel.text = "어린이집"
        } else if chat?.category == "육아" {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            categoryLabel.textColor = .white
            categoryLabel.textAlignment = .center
            categoryLabel.text = "육아"
        } else if chat?.category == "잡담" {
            categoryLabel.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            categoryLabel.textColor = .white
            categoryLabel.textAlignment = .center
            categoryLabel.text = "잡담"
        }
    }
    func drawTime() {
        addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
    }
    func drawVendor() {
        addSubview(faceImgView)
        faceImgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        faceImgView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        addSubview(vendorLabel)
        vendorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        vendorLabel.leftAnchor.constraint(equalTo: faceImgView.rightAnchor).isActive = true

    }
    func drawBorderLine() {
        addSubview(borderLineImgView)
        borderLineImgView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        borderLineImgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    func drawCommentCountLabel() {
        addSubview(commentCountLabel)
        commentCountLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        commentCountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        commentCountLabel.bottomAnchor.constraint(equalTo: borderLineImgView.topAnchor).isActive = true
    }
    func downloadImg(imgFileName: String) {
        imgView.kf.indicatorType = .activity
        if DBUtil.shared.loadImgFromCache(imgFileName) == nil {
            imgView.kf.indicator?.startAnimatingView()
            DBUtil.shared.loadChatImgsFromStorage(imgFileName) { url in
                let resource = ImageResource(downloadURL: url, cacheKey: imgFileName)
                self.imgView.kf.setImage(with: resource)
                self.imgView.kf.indicator?.stopAnimatingView()
            }
        } else {
            imgView.image = DBUtil.shared.loadImgFromCache(imgFileName)
        }
    }
}
