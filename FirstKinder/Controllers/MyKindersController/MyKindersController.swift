//
//  MyKinders.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit

class MyKindersController: UIViewController {
    override func viewDidLoad() {
        configureUI()
    }
    func configureUI() {
        self.navigationController?.navigationBar.topItem?.title = "관심 어린이집"
        view.backgroundColor = .white
    }
}
