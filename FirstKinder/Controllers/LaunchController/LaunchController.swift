//
//  ViewController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import RxSwift

class LaunchController: UIViewController, XMLParserDelegate {
    var kinder = Kinder()
    var disposeBag = DisposeBag()
    var tagKind = TagKind.title
    var kinderPublisher = PublishSubject<Kinder>()
    var kinder$: Observable<Kinder> {
        return kinderPublisher.asObservable()
    }
    var titleImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imgView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        DispatchQueue.global(qos: .background).async {
            self.getData()
        }
        kinder$
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
            kinders.append($0)
            print($0)
        },onCompleted: {
            print("FINISH!")
            self.navigationController?.pushViewController(MainController(), animated: true)
        }).disposed(by: self.disposeBag)
    }
    override func viewDidAppear(_ animated: Bool) {
    }
}

