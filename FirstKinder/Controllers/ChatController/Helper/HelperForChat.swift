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
        let gearButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(handleGearTap))
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = gearButton

        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        view.addSubview(floatingButton)
        floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20).isActive = true
        floatingButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
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
