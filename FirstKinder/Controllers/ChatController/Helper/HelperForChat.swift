//
//  HelperForDiary.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

extension ChatController {
    func configureUI () {
        self.navigationController?.navigationBar.topItem?.title = "육아 잡담"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handleChatTap))

        view.backgroundColor = .white
        self.collectionView.backgroundColor = .white
    }
}
