//
//  ViewController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit

class LaunchController: UIViewController, XMLParserDelegate {
    var kinder = Kinder()
    var tagKind = TagKind.title
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getData()
    }
    override func viewDidAppear(_ animated: Bool) {
        kinders.forEach({
            print("\($0.title), \($0.isOn)")
            print("\($0.city), \($0.gu)")
            print("\($0.tel)")
            print("\($0.la), \($0.lo)")
            print("\($0.craddr)")
            print("----------------------")
        })
    }
}

