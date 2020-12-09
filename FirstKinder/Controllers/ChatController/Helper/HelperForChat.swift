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
    }
    func configureIndicator() {
        indicator.color = .black
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        indicator.hidesWhenStopped = true
    }
    
}
