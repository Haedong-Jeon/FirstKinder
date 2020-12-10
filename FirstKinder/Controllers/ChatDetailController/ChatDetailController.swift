//
//  ChatDetailController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

let commentCellReuseIdentifier = "reuse identifer for comment cell"
let headerReuseIdentifier = "header reuse identifier"

class ChatDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var chat: Chat?
    override func viewDidLoad() {
        configureUI()
    }
}
