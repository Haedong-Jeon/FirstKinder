//
//  imgExtension.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/12.
//

import UIKit

extension UIImageView {
    @objc func makeBigWhenTouched() {
        self.isUserInteractionEnabled = true
        let bigImgController = BigSizeImgViewController()
        bigImgController.img = self.image
        bigImgController.modalPresentationStyle = .fullScreen
        topMostController?.present(bigImgController, animated: true, completion: nil)
    }
    func addMakeBigFunction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(makeBigWhenTouched))
        self.addGestureRecognizer(tapGesture)
    }
}