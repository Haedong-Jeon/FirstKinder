//
//  BigSizeImgViewController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/12.
//

import UIKit

class BigSizeImgViewController: UIViewController {
    var imgView: UIImageView = {
        var imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .black
        return imgView
    }()
    var closeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(handleCloseButtonTap), for: .touchUpInside)
        button.setTitle("x", for: .normal)
        return button
    }()
    var img: UIImage?
    
    override func viewDidLoad() {
        configureUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if img != nil {
            imgView.image = img
        }
    }
}
