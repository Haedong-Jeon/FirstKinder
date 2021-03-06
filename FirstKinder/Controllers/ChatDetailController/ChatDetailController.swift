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
let commentToCommentCellReuseIdentifier = "reuse identifier for commentToComment Cell"
let commentCellWithImgReuseIdentifier = "reuse identifier for comment cell with img"
let commentToCommentCellWithImgReuseIdentifier = "resue identifier for commentToComment Cell with Img"

class ChatDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var chat: Chat?
    var isCommentToComment = false
    var targetCommentUid = ""
    var isCommentEditing = false
    var isEditTargetCommentHasIMg = false
    
    var editingIdx: IndexPath?
    var thisComments: [Comment] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var commentToComments = [Comment]()
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
        let indicator = ANActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30), animationType: .ballPulse, color: .black, padding: .none)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        indicator.startAnimating()
        DBUtil.shared.loadCommentTexts { loadedComments in
            comments = loadedComments
            self.thisComments = comments
                .filter({$0.targetChatUid == self.chat?.uid && $0.isCommentToComment == nil && $0.reportCount < 6})
                                    .sorted(by: {$0.timeStamp < $1.timeStamp})
                
            self.commentToCommentControl()
            indicator.stopAnimating()
        }
        configureUI()
        setRx()
        setSubscriberForRx()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavBar()
    }
    func commentToCommentControl() {
        if self.thisComments.isEmpty { return }
        
        self.commentToComments = comments
                                    .filter({$0.isCommentToComment != nil})
                                    .sorted(by: {$0.timeStamp < $1.timeStamp})

        if self.commentToComments.isEmpty { return }

        var mergedComments = [Comment]()
        
        for i in 0 ... thisComments.count - 1 {
            var tempCmts = [Comment]()
            mergedComments.append(thisComments[i])
            commentToComments.forEach({
                if mergedComments.last!.uid == $0.targetCommentUid {
                    tempCmts.append($0)
                }
            })
            mergedComments += tempCmts
            tempCmts.removeAll()
        }
        thisComments = mergedComments
    }
}


