//
//  KinderCell.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit

let labelCellReuseIdentifier = "reuse identifier for label reuse"
class KinderCell: UICollectionViewCell {
  
    var kinderTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    var kinderPositionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    var kinderIsOnLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        return label
    }()
    var carAvailableLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        label.backgroundColor = .systemPink
        label.textAlignment = .center
        label.textColor = .white
        label.text = "차량 운행"
        label.clipsToBounds = true
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
        backgroundColor = .white
        drawKinderIsOn()
        drawCarAvailableLabel()
        drawKinderTitle()
        drawKinderPosition()
    }
    func drawKinderTitle() {
        addSubview(kinderTitleLabel)
        kinderTitleLabel.topAnchor.constraint(equalTo: kinderIsOnLabel.bottomAnchor, constant: 5).isActive = true
        kinderTitleLabel.widthAnchor.constraint(equalToConstant: frame.width - 10).isActive = true
        kinderTitleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        kinderTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func drawKinderPosition() {
        addSubview(kinderPositionLabel)
        kinderPositionLabel.topAnchor.constraint(equalTo: kinderTitleLabel.bottomAnchor).isActive = true
        kinderPositionLabel.widthAnchor.constraint(equalToConstant: frame.width - 10).isActive = true
        kinderPositionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        kinderPositionLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
    }
    func drawKinderIsOn() {
        addSubview(kinderIsOnLabel)
        kinderIsOnLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        kinderIsOnLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        
        kinderIsOnLabel.backgroundColor = .link
        kinderIsOnLabel.textColor = .white
        kinderIsOnLabel.textAlignment = .center
        kinderIsOnLabel.text = "정상"
    }
    func drawCarAvailableLabel() {
        addSubview(carAvailableLabel)
        carAvailableLabel.topAnchor.constraint(equalTo: kinderIsOnLabel.topAnchor).isActive = true
        carAvailableLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    }
}
