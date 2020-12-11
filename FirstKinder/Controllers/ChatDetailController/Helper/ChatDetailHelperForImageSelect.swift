//
//  ChatDetailHelperForImageSelect.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/11.
//

import UIKit

extension ChatDetailController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImg = info[.originalImage] as? UIImage else { return }
        self.imgView.image = selectedImg
        redrawViewsWithImg()
        dismiss(animated: true, completion: nil)
    }
}
