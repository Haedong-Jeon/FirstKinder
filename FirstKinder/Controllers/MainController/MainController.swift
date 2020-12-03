//
//  MainController.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit

class MainController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        configureUI()
        setTabs()
    }
    func configureUI() {
        view.backgroundColor = .white
    }
    func setTabs() {
        let kinderListController = ListController(collectionViewLayout: UICollectionViewFlowLayout())
        kinderListController.tabBarItem.image = UIImage(systemName: "list.dash")
        kinderListController.tabBarItem.title = "어린이집 목록"
        
        let myKindersController = MyKindersController()
        myKindersController.tabBarItem.image = UIImage(systemName: "heart.fill")
        myKindersController.tabBarItem.title = "관심 어린이집"
        
        let controllers = [kinderListController, myKindersController]
        viewControllers = controllers.map({UINavigationController(rootViewController: $0)})//탭안의 뷰컨트롤러들에게 네비 바 붙이기.
    }
}
