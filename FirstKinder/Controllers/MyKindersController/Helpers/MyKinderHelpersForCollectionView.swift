//
//  MyKinderHelpersForCollectionView.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit

extension MyKindersController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? KinderCell else {
            return UICollectionViewCell()
        }
        cell.kinderTitleLabel.text = myKinders[indexPath.row].title
        cell.kinderPositionLabel.text = myKinders[indexPath.row].craddr
        cell.kinderIsOnLabel.text = myKinders[indexPath.row].isOn
        
        if cell.kinderIsOnLabel.text == "정상" {
            cell.kinderIsOnLabel.textColor = .systemBlue
        } else if cell.kinderIsOnLabel.text == "폐지" {
            cell.kinderIsOnLabel.textColor = .systemPink
        } else if cell.kinderIsOnLabel.text == "휴지" {
            cell.kinderIsOnLabel.textColor = .systemYellow
        } else if cell.kinderIsOnLabel.text == "재개" {
            cell.kinderIsOnLabel.textColor = .systemGreen
        }
        guard let currentChildNum = Int(myKinders[indexPath.row].currentNumOfChild) else { return UICollectionViewCell() }
         
        if myKinders[indexPath.row].isCarAvailable != "운영" {
            cell.carAvailableLabel.backgroundColor = .white
        } else {
            cell.carAvailableLabel.backgroundColor = .systemPink
        }
        cell.layer.cornerRadius = 10
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myKinders.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kinder = myKinders[indexPath.row]
        let detailViewController = KinderDetailController()
        detailViewController.kinder = kinder
        detailViewController.isFromMyKinder = true
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        
        self.navigationController?.view.layer.add(transition, forKey: nil)

        navigationController?.pushViewController(detailViewController, animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: 95)
    }
}
