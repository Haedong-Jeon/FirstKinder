//
//  ChatDetailHelperForBasicUI.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit

extension ChatDetailController {
    func configureUI() {
        view.backgroundColor = .white
        drawCommentTextView()
        configureCollectionView()
        configureNavBar()
    }
    func configureCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: commentCellReuseIdentifier)
        collectionView.register(ChatDetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: commentTextView.topAnchor).isActive = true
        
    }
    func configureNavBar() {
        let gearButton = UIBarButtonItem.init(image: #imageLiteral(resourceName: "gear"), style: .plain, target: self, action: #selector(handleGearButtonTap))
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = gearButton
    }
    func drawCommentTextView() {
        view.addSubview(commentTextView)
        commentTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        commentTextView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        commentTextView.layer.cornerRadius = 10
        commentTextView.layer.borderWidth = 2
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        
        let keyboardToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        keyboardToolbar.barStyle = .default
        keyboardToolbar.items = [
            UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(keyBoardCameraButtonTap)),
            UIBarButtonItem(image: UIImage(systemName: "photo"), style: .plain, target: self, action: #selector(keyBoardPhotoButtonTap)),
            UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(keyBoardDoneButtonTap)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            uploadButton
        ]
        keyboardToolbar.tintColor = .black
        keyboardToolbar.sizeToFit()
        imgPicker.delegate = self
        commentTextView.inputAccessoryView = keyboardToolbar
    }
    func redrawViewsWithImg() {
        view.addSubview(imgView)
        imgView.isUserInteractionEnabled = true
        imgView.bottomAnchor.constraint(equalTo: commentTextView.topAnchor).isActive = true
        imgView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        addImgEraseButton()
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
    func redrawViewsWithoutImg() {
        imgView.removeFromSuperview()
    }
}
