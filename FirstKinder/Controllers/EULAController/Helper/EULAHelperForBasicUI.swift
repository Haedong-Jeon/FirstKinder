//
//  EULAHelperForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/17.
//

import UIKit

extension EULAController {
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(EULAWeb)
        
        
        let buttonStack = UIStackView(arrangedSubviews: [agreeButton, notAgreeButton])
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.distribution = .fillProportionally
        
        view.addSubview(buttonStack)
        buttonStack.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonStack.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        EULAWeb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        EULAWeb.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        EULAWeb.bottomAnchor.constraint(equalTo: buttonStack.topAnchor).isActive = true
        
        
        loadEULAWeb()
        
    }
}

extension EULAController {
    func loadEULAWeb() {
        guard let EULA = URL(string:"https://www.apple.com/kr/legal/internet-services/itunes/kr/terms.html") else { return }
        let EULARequest = URLRequest(url: EULA)
        EULAWeb.load(EULARequest)
    }
}
