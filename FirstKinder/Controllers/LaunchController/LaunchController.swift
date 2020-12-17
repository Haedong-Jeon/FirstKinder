//
//  ViewController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import RxSwift
import ANActivityIndicator

class LaunchController: UIViewController, XMLParserDelegate {
    var userUploadImgLoadComplete = false
    var commentImgLoadComplete = false
    var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "CookieRun", size: 65)
        label.textAlignment = .center
        return label
    }()
    var titleImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imgView
    }()
    var heartImgView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imgView
    }()
    var heartImgView2: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return imgView
    }()
    var guidanceMsgLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .justified
        return label
    }()
    var dataSourceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    var disposeBag = DisposeBag()
    let indicator = ANActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30), animationType: .ballSpinFadeLoader, color: .white, padding: .none)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appVersionCheck()
        configureUI()
        indicator.startAnimating()
        initializeApp()
    }
    func initializeApp() {
        //게시글에 첨부된 이미지와 댓글에 첨부된 이미지를 비동기적으로 불러온다.
        //어느쪽이든 먼저 완료되면 어린이집 데이터를 받아온다.
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.guidanceMsgLabel.text = "이미지 로드 중..."
            }
            self.loadUploadUserImgs()
            self.loadCommentsImgs()
            self.loadKinders()
        }
    }
    func loadUploadUserImgs() {
        DBUtil.shared.loadAllUserUploadImgs().subscribe(onError: { error in
            if error is NoImgError {
                self.userUploadImgLoadComplete = true
            }
        }, onCompleted: {
            self.userUploadImgLoadComplete = true
        }).disposed(by: self.disposeBag)
    }
    func loadCommentsImgs() {
        DBUtil.shared.loadAllCommentImgs().subscribe(onError: { error in
            if error is NoImgError {
                self.commentImgLoadComplete = true
            }
        }, onCompleted: {
            self.commentImgLoadComplete = true
        }).disposed(by: self.disposeBag)
    }
    func loadKinders() {
        createKinderDataObservable()
            .subscribe(onNext: { resultNum in
                DispatchQueue.main.async {
                    self.guidanceMsgLabel.text = cityNames[resultNum % cityNames.count] + "...의 데이터를 불러오는 중...!!"
                }
            },onCompleted: {
                if self.userUploadImgLoadComplete && self.commentImgLoadComplete {
                    self.goNextPage()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.goNextPage()
                    }
                }
            }).disposed(by: disposeBag)
    }
    func createKinderDataObservable() -> Observable<Int> {
        return Observable.create { checker in
            var count = 0
            var loadResult: Error? {
                didSet {
                    checker.onNext(count)
                    count += 1
                }
            }
            for i in 0 ... cities.count - 1 {
                loadResult = ParsingUtil.shared.getData(cityCode: cities[i])
            }
            if count == cities.count {
                checker.onCompleted()
            }
            return Disposables.create()
        }
    }
    func appVersionCheck() {
        if let data = UserDefaults.standard.value(forKey:"myKinders") as? Data {
            do {
                myKinders = try PropertyListDecoder().decode(Array<Kinder>.self, from: data)
            } catch {
                let showErrorAlert = UIAlertController(title: "초기화 에러", message: "호환성에 문제가 발생했습니다. 앱을 삭제 후 최신 버전을 설치 해주세요.", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .default) { ACTION in
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }
                showErrorAlert.addAction(okButton)
                self.present(showErrorAlert, animated: false, completion: nil)
            }
        }
    }
    func goNextPage() {
        let EULAAgree = UserDefaults.standard.bool(forKey: "EULA")
        if EULAAgree {
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            transition.type = .fade
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(MainController(), animated: false)
            }
        } else {
            let transition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            transition.type = .fade
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(EULAController(), animated: false)
            }
        }
    }
}

