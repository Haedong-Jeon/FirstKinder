//
//  SelectorForChatWrite.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import UIKit

extension ChatWriteController {
    @objc func keyBoardCameraButtonTap() {
        imgPicker.sourceType = .camera
        present(imgPicker, animated: true, completion: nil)
    }
    @objc func keyBoardPhotoButtonTap() {
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: true, completion: nil)
    }
    @objc func keyBoardDoneButtonTap() {
        view.endEditing(true)
    }
    @objc func handleEraseImgTap() {
        if imgView.image != nil {
            imgView.image = nil
            redrawViewsWithoutImg()
        }
    }
    @objc func handleUpload() {
        
    }
}
