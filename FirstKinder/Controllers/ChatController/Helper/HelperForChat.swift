//
//  HelperForDiary.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

extension ChatController {
    func configureUI () {
        self.navigationController?.navigationBar.topItem?.title = "이야기"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(handleChatTap))

        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
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