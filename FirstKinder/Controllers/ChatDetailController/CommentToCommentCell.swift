//
//  CommentToCommentCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

class CommentToCommentCell: CommentCell {
    var ctcMark: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "┗"
        label.textColor = .lightGray
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func configureUI() {
        backgroundColor = .white
        //대댓글 마크
        addSubview(ctcMark)
        ctcMark.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        ctcMark.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        //얼굴 마크
        addSubview(faceImgView)
        faceImgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        faceImgView.leftAnchor.constraint(equalTo: ctcMark.rightAnchor, constant: 10).isActive = true
        //벤더 식별자
        addSubview(vendorLabel)
        vendorLabel.topAnchor.constraint(equalTo: faceImgView.topAnchor).isActive = true
        vendorLabel.leftAnchor.constraint(equalTo: faceImgView.rightAnchor, constant: 10).isActive = true
        
        //수정, 삭제 버튼
        addSubview(verticalDotButton)
        verticalDotButton.topAnchor.constraint(equalTo: faceImgView.topAnchor).isActive = true
        verticalDotButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        
        //시간
        addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: faceImgView.topAnchor).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: verticalDotButton.leftAnchor, constant: -10).isActive = true
        
        //댓글 본문
        addSubview(commentBodyLabel)
        commentBodyLabel.topAnchor.constraint(equalTo: faceImgView.bottomAnchor, constant: 5).isActive = true
        commentBodyLabel.leftAnchor.constraint(equalTo: faceImgView.leftAnchor).isActive = true
        commentBodyLabel.rightAnchor.constraint(equalTo: verticalDotButton.leftAnchor, constant: -5).isActive = true
        commentBodyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        //경계선
        addSubview(borderLineImgView)
        borderLineImgView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        borderLineImgView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true

    }
}

