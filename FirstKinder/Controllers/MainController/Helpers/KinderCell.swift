//
//  KinderCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit

class KinderCell: UICollectionViewCell {
    var kinderTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "CookieRun", size: 20)
        return label
    }()
    var kinderPositionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var kinderIsOnLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var medalForManyChildImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.layer.cornerRadius = 25
        imgView.clipsToBounds = true
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
        addSubview(kinderTitleLabel)
        kinderTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        kinderTitleLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func drawKinderPosition() {
        addSubview(kinderPositionLabel)
        kinderPositionLabel.topAnchor.constraint(equalTo: kinderTitleLabel.bottomAnchor).isActive = true
        kinderPositionLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderPositionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func drawKinderIsOn() {
        addSubview(kinderIsOnLabel)
        kinderIsOnLabel.topAnchor.constraint(equalTo: kinderPositionLabel.bottomAnchor).isActive = true
        kinderIsOnLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderIsOnLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func drawFaceIcon() {
        addSubview(medalForManyChildImgView)
        medalForManyChildImgView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,constant: -20).isActive = true
        medalForManyChildImgView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    }
}
