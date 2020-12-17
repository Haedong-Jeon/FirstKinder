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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
