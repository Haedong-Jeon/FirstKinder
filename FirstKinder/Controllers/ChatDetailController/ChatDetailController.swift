//
//  ChatDetailController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/10.
//

import UIKit
import ANActivityIndicator
import RxSwift
import RxCocoa

let commentCellReuseIdentifier = "reuse identifer for comment cell"
let headerReuseIdentifier = "header reuse identifier"

class ChatDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var chat: Chat?
    var isCommentEditing = false
    var isEditTargetCommentHasIMg = false
    var tapedCommentImg: UIImage?
    var editingIdx: IndexPath?
    var thisComments: [Comment] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    let uploadButton = UIBarButtonItem(image: UIImage(systemName: "capslock.fill"), style: .plain, target: self, action: #selector(handleUploadTap))
    let imgPicker = UIImagePickerController()
    var comment$: Observable<Bool>?
    var commentTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    var imgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imgView.layer.cornerRadius = 5
        imgView.layer.borderWidth = 1
        imgView.layer.borderColor = UIColor.lightGray.cgColor
        imgView.clipsToBounds = true
        return imgView
    }()
    override func viewDidLoad() {
        configureUI()
        let indicator = ANActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30), animationType: .ballPulse, color: .black, padding: .none)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        indicator.startAnimating()
        DBUtil.shared.loadCommentTexts { loadedComments in
            comments = loadedComments
            self.thisComments = comments
                                    .filter({$0.targetChatUid == self.chat?.uid})
                                    .sorted(by: {$0.timeStamp < $1.timeStamp})
            indicator.stopAnimating()
        }
        setRx()
        setSubscriberForRx()
    }
    func editButtonsUnlock() {
        guard let cells = collectionView.visibleCells as? [CommentCell] else { return }
        cells.forEach({$0.editButton.isUserInteractionEnabled = true})
    }
    func otherEditButtonsLock() {
        guard let cells = collectionView.visibleCells as? [CommentCell] else { return }
        for _cell in cells {
            if _cell.editButton.backgroundColor != .white {
                _cell.editButton.isUserInteractionEnabled = false
            }
        }
    }
}

