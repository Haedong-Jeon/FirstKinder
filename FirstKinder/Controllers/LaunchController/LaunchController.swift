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
    var cities = ["27200","27710","27140","27230","27170","27260","27110","27290"]
    var isLastCity = false
    var titleTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.init(name: "CookieRun", size: 65)
        textView.textAlignment = .center
        return textView
    }()
    var titleImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imgView
    }()
    var kinderTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.textAlignment = .center
        return textView
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

