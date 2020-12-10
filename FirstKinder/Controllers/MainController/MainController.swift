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
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    func configureUI() {
        view.backgroundColor = .white
    }
    func setTabs() {
        let kinderListController = ListController(collectionViewLayout: UICollectionViewFlowLayout())
        kinderListController.tabBarItem.image = UIImage(systemName: "list.dash")
        kinderListController.tabBarItem.title = "어린이집 목록"
        
        let nearKinderController = NearKinderController()
        nearKinderController.tabBarItem.image = UIImage(systemName: "mappin.and.ellipse")
        nearKinderController.tabBarItem.title = "근처 어린이집"
        
        let parentsChatController = ChatController(collectionViewLayout: UICollectionViewFlowLayout())
        parentsChatController.tabBarItem.image = UIImage(systemName: "quote.bubble.fill")
        parentsChatController.tabBarItem.title = "이야기"
        
        let myKindersController = MyKindersController(collectionViewLayout: UICollectionViewFlowLayout())
        myKindersController.tabBarItem.image = UIImage(systemName: "heart.fill")
        myKindersController.tabBarItem.title = "관심 어린이집"
        
        let controllers = [kinderListController, nearKinderController, parentsChatController, myKindersController]
        viewControllers = controllers.map({UINavigationController(rootViewController: $0)})//탭안의 뷰컨트롤러들에게 네비 바 붙이기.
    }
}
