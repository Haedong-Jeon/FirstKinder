//
//  KinderCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit

class KinderCell: UICollectionViewCell {
    var kinderTitleTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.init(name: "CookieRun", size: 20)
        textView.isEditable = false
        return textView
    }()
    var kinderPositionTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    var kinderIsOnTextview: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        return textView
    }()
    var faceIconImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.layer.cornerRadius = 25
        imgView.clipsToBounds = true
        imgView.backgroundColor = .link
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
        backgroundColor = .white
        drawKinderTitle()
        drawKinderPosition()
        drawKinderIsOn()
        drawFaceIcon()
    }
    func drawKinderTitle() {
        addSubview(kinderTitleTextView)
        kinderTitleTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        kinderTitleTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderTitleTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func drawKinderPosition() {
        addSubview(kinderPositionTextView)
        kinderPositionTextView.topAnchor.constraint(equalTo: kinderTitleTextView.bottomAnchor).isActive = true
        kinderPositionTextView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderPositionTextView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func drawKinderIsOn() {
        addSubview(kinderIsOnTextview)
        kinderIsOnTextview.topAnchor.constraint(equalTo: kinderPositionTextView.bottomAnchor).isActive = true
        kinderIsOnTextview.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderIsOnTextview.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func drawFaceIcon() {
        addSubview(faceIconImgView)
        faceIconImgView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,constant: -20).isActive = true
        faceIconImgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
