//
//  EULAController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/17.
//

import UIKit
import WebKit

class EULAController: UIViewController {
    var EULAWeb: WKWebView = {
        var webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.white
        return webView
    }()
    var agreeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("동의", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleAgreeButtonTouched), for: .touchUpInside)
        button.backgroundColor = .link
        return button
    }()
    var notAgreeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("동의 안함", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleNotAgreeButtonTouched), for: .touchUpInside)
        button.backgroundColor = .darkGray
        return button
    }()
    override func viewDidLoad() {
        configureUI()
    }
}
