//
//  ViewController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import RxSwift

class LaunchController: UIViewController, XMLParserDelegate {
    var kinder = Kinder()
    var disposeBag = DisposeBag()
    var tagKind = TagKind.title
    var titleImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imgView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        DispatchQueue.global(qos: .background).async {
            self.getData()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
    }
}

