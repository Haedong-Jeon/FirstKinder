//
//  CommentCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

class CommentCellWithImg: UICollectionViewCell {
    
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
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
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
        imgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        return imgView
    }()
    var upArrowForCommentToComment: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.text = "↑"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        configureUI()
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
        guard let selectedIndexPath = self.thisIdxPath else { return }
        
        deleteDelegate?.dotTap(indexPath: selectedIndexPath)
    }
    func configureUI() {
        backgroundColor = .white
        //얼굴 마크
        addSubview(faceImgView)
        faceImgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        faceImgView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        //벤더 식별자
        addSubview(vendorLabel)
        vendorLabel.topAnchor.constraint(equalTo: faceImgView.topAnchor).isActive = true
        vendorLabel.leftAnchor.constraint(equalTo: faceImgView.rightAnchor, constant: 10).isActive = true
        
        //수정, 삭제 버튼
        addSubview(verticalDotButton)
        verticalDotButton.topAnchor.constraint(equalTo: faceImgView.topAnchor).isActive = true
        verticalDotButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        //시간
        addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: faceImgView.topAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: verticalDotButton.leftAnchor, constant: -10).isActive = true
        
        //댓글 본문
        addSubview(commentBodyLabel)
        commentBodyLabel.topAnchor.constraint(equalTo: faceImgView.bottomAnchor, constant: 5).isActive = true
        commentBodyLabel.leftAnchor.constraint(equalTo: faceImgView.leftAnchor).isActive = true
        commentBodyLabel.rightAnchor.constraint(equalTo: verticalDotButton.leftAnchor, constant: -5).isActive = true
        
        //첨부된 이미지 표시
        addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: commentBodyLabel.bottomAnchor, constant: 5).isActive = true
        imgView.leftAnchor.constraint(equalTo: commentBodyLabel.leftAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        //경계선
        addSubview(borderLineImgView)
        borderLineImgView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        borderLineImgView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

