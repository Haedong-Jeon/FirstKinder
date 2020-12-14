//
//  ViewController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit
import RxSwift

class LaunchController: UIViewController, XMLParserDelegate {

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
    var kinderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var dataSourceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
//        DispatchQueue.global(qos: .background).async {
//            DBUtil.shared.loadAllImg()
//        }
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
        configureUI()
        DispatchQueue.global(qos: .background).async {
            if ParsingUtil.shared.getData(cityCode: cities[0]) == nil {
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                transition.type = .fade
                DispatchQueue.main.async {
                    self.navigationController?.view.layer.add(transition, forKey: nil)
                    self.navigationController?.pushViewController(MainController(), animated: false)
                }
            }
        }
    }
}

