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
        return label
    }()
    var overFiftyLabel: UILabel = {
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
        drawOverFiftylabel()
        drawCarAvailableLabel()
        drawKinderTitle()
        drawKinderPosition()
        drawKinderIsOn()
    }
    func drawKinderTitle() {
        addSubview(kinderTitleLabel)
        kinderTitleLabel.topAnchor.constraint(equalTo: carAvailableLabel.bottomAnchor, constant: 5).isActive = true
        kinderTitleLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderTitleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    func drawKinderPosition() {
        addSubview(kinderPositionLabel)
        kinderPositionLabel.topAnchor.constraint(equalTo: kinderTitleLabel.bottomAnchor).isActive = true
        kinderPositionLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
    }
    func drawKinderIsOn() {
        addSubview(kinderIsOnLabel)
        kinderIsOnLabel.topAnchor.constraint(equalTo: kinderPositionLabel.bottomAnchor).isActive = true
        kinderIsOnLabel.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor).isActive = true
        kinderIsOnLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        kinderIsOnLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func drawOverFiftylabel() {
        addSubview(overFiftyLabel)
        overFiftyLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor,constant: -20).isActive = true
        overFiftyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        overFiftyLabel.backgroundColor = .systemPink
        overFiftyLabel.textColor = .white
        overFiftyLabel.textAlignment = .center
        overFiftyLabel.text = "50명 ↑"
    }
    func drawCarAvailableLabel() {
        addSubview(carAvailableLabel)
        carAvailableLabel.rightAnchor.constraint(equalTo: overFiftyLabel.leftAnchor, constant: -10).isActive = true
        carAvailableLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        carAvailableLabel.backgroundColor = .black
        carAvailableLabel.textColor = .white
        carAvailableLabel.textAlignment = .center
        carAvailableLabel.text = "차량 운행"
    }
}
