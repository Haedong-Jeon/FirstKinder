//
//  MainHelperForCollectionView.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//
import UIKit

extension ListController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? KinderCell else {
            return UICollectionViewCell()
        }
        cell.kinderTitleLabel.text = nowShowingKinders[indexPath.row].title
        cell.kinderPositionLabel.text = nowShowingKinders[indexPath.row].craddr
        cell.kinderIsOnLabel.text = nowShowingKinders[indexPath.row].isOn
        
        if cell.kinderIsOnLabel.text == "정상" {
            cell.kinderIsOnLabel.textColor = .systemBlue
        } else if cell.kinderIsOnLabel.text == "폐지" {
            cell.kinderIsOnLabel.textColor = .systemPink
        } else if cell.kinderIsOnLabel.text == "휴지" {
            cell.kinderIsOnLabel.textColor = .systemYellow
        } else if cell.kinderIsOnLabel.text == "재개" {
            cell.kinderIsOnLabel.textColor = .systemGreen
        }
        guard let currentChildNum = Int(nowShowingKinders[indexPath.row].currentNumOfChild) else { return UICollectionViewCell() }
        if currentChildNum >= 50 {
            cell.medalForManyChildImgView.image = #imageLiteral(resourceName: "medal")
        } else {
            cell.medalForManyChildImgView.image = nil
        }
//        cell.layer.borderWidth = 2
//        cell.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.layer.cornerRadius = 10
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowShowingKinders.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kinder = nowShowingKinders[indexPath.row]
        let detailViewController = DetailController()
        detailViewController.kinder = kinder
        
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
