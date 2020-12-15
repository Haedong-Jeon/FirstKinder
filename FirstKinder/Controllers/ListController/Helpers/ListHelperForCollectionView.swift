//
//  MainHelperForCollectionView.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//
import UIKit
import ANActivityIndicator

extension ListController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? KinderCell else {
            return UICollectionViewCell()
        }
        cell.kinderTitleLabel.text = nowShowingKinders[indexPath.row].title
        cell.kinderPositionLabel.text = nowShowingKinders[indexPath.row].craddr
        cell.kinderIsOnLabel.text = nowShowingKinders[indexPath.row].isOn
        
        if cell.kinderIsOnLabel.text == "정상" {
            cell.kinderIsOnLabel.backgroundColor = .link
        } else if cell.kinderIsOnLabel.text == "폐지" {
            cell.kinderIsOnLabel.backgroundColor = .red
        } else if cell.kinderIsOnLabel.text == "휴지" {
            cell.kinderIsOnLabel.backgroundColor = .orange
        } else if cell.kinderIsOnLabel.text == "재개" {
            cell.kinderIsOnLabel.backgroundColor = .systemGreen
        }
        
        if nowShowingKinders[indexPath.row].isCarAvailable != "운영" {
            cell.carAvailableLabel.backgroundColor = .white
        } else {
            cell.carAvailableLabel.backgroundColor = .systemIndigo
        }
        
        let currentChildNum = Int(nowShowingKinders[indexPath.row].currentNumOfChild) ?? 0
        if currentChildNum < 50 {
            cell.overFiftyLabel.backgroundColor = .white
        } else {
            cell.overFiftyLabel.backgroundColor = .systemPink
        }
        cell.layer.cornerRadius = 10
        scrollChecker = true
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowShowingKinders.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kinder = nowShowingKinders[indexPath.row]
        let detailViewController = KinderDetailController()
        detailViewController.kinder = kinder
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        
        self.navigationController?.view.layer.add(transition, forKey: nil)
        
        navigationController?.pushViewController(detailViewController, animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 110)
    }
    func getEstimatedHeightFromDummyCell(_ indexPath: IndexPath) -> CGFloat{
        let width = view.frame.width - 10
        let estimatedHeight: CGFloat = 800.0
        let dummyCell = KinderCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
        dummyCell.kinderTitleLabel.text = nowShowingKinders[indexPath.row].title
        dummyCell.kinderPositionLabel.text = nowShowingKinders[indexPath.row].craddr
        dummyCell.kinderIsOnLabel.text = nowShowingKinders[indexPath.row].isOn
        
        dummyCell.layoutIfNeeded()
        let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
        return estimateSize.height
    }
}
//무한 스크롤 구현.
//extension ListController {
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if !scrollChecker { return }
//        let contentOffsetY = scrollView.contentOffset.y
//        if contentOffsetY >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 /* Needed offset */ {
//            print("스크롤이 바닥에 도달! offset - \(contentOffsetY)")
//
//            let loadResult = ParsingUtil.shared.getData(cityCode: cities[ParsingUtil.shared.loadedCityCount])
//            print("데이터 파싱...!!")
//            if loadResult == nil {
//                self.nowShowingKinders = kinders
//                self.scrollChecker = false
//                print("현재 데이터 - \(kinders.count)")
//            }
//
//        }
//    }
//}
