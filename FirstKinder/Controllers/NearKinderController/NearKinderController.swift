//
//  NearKinderController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit

class NearKinderController: UIViewController {
    override func viewDidLoad() {
        configureUI()
    }
    func configureUI() {
        self.navigationController?.navigationBar.topItem?.title = "근처 어린이집"
        view.backgroundColor = .white
    }
}
