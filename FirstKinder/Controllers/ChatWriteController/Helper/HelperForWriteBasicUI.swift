//
//  HelperForWriteBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

extension ChatWriteController {
    func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.topItem?.title = "육아 잡담 쓰기"
        view.addSubview(chatBodyTextView)
        chatBodyTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        chatBodyTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        chatBodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
