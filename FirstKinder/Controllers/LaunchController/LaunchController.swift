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
    var progressBar = UIProgressView()
    //대구 광역시 시군구 코드들
    var cities = ["27200","27710","27140","27230","27170","27260","27110","27290"]
    
    //서울 시군구 코드들
    //var cities = ["11680", "11740", "11305", "11500", "11620", "11215", "11530", "11545", "11350", "11320", "11230", "11590", "11440", "11410", "11650", "11200", "11290", "11710", "11470", "11560", "11170", "11380", "11110", "11140", "11260"]
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "CookieRun", size: 65)
        label.textAlignment = .center
        return label
    }()
    var titleImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imgView
    }()
    var kinderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        return label
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

