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
        view.addSubview(chatBodyTextView)
        drawCategoryRadioButtonsView()
        chatBodyTextView.topAnchor.constraint(equalTo: categoryRadioButtonView.bottomAnchor).isActive = true
        chatBodyTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        chatBodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    func redrawViewsWithImg() {
        
        chatBodyTextView.removeFromSuperview()
        
        view.addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: categoryRadioButtonView.bottomAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imgView.isUserInteractionEnabled = true

        view.addSubview(chatBodyTextView)
        chatBodyTextView.topAnchor.constraint(equalTo: imgView.bottomAnchor).isActive = true
        chatBodyTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        chatBodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        addImgEraseButton()
        
        drawCategoryRadioButtonsView()
    }
    func redrawViewsWithoutImg() {
        imgView.removeFromSuperview()
        chatBodyTextView.removeFromSuperview()
        
        view.addSubview(chatBodyTextView)
        chatBodyTextView.topAnchor.constraint(equalTo: categoryRadioButtonView.topAnchor).isActive = true
        chatBodyTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        chatBodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        drawCategoryRadioButtonsView()

    }
    func addImgEraseButton() {
        let eraseImgButton = UIButton(type: .system)
        eraseImgButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        eraseImgButton.tintColor = .lightGray
        eraseImgButton.translatesAutoresizingMaskIntoConstraints = false
        eraseImgButton.sizeToFit()
        eraseImgButton.addTarget(self, action: #selector(handleEraseImgTap), for: .touchUpInside)
        imgView.addSubview(eraseImgButton)
        
        eraseImgButton.topAnchor.constraint(equalTo: imgView.topAnchor).isActive = true
        eraseImgButton.rightAnchor.constraint(equalTo: imgView.rightAnchor).isActive = true
    }
    func drawCategoryRadioButtonsView() {
        categoryRadioButtonView.translatesAutoresizingMaskIntoConstraints = false
        categoryRadioButtonView.backgroundColor = .lightGray
        view.addSubview(categoryRadioButtonView)
        categoryRadioButtonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        categoryRadioButtonView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        categoryRadioButtonView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        categoryRadioButtonView.setButtonTitles(firstTitle: "어린이집", secondTitle: "육아", thirdTitle: "잡담")
    }
}
