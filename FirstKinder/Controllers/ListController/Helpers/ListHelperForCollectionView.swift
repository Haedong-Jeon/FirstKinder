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
        if currentChildNum < 50 {
            cell.overFiftyLabel.backgroundColor = .white
        } else {
            cell.overFiftyLabel.backgroundColor = .systemPink
        }
        
        if nowShowingKinders[indexPath.row].isCarAvailable != "운영" {
            cell.carAvailableLabel.backgroundColor = .white
        } else {
            cell.carAvailableLabel.backgroundColor = .black
        }
        cell.layer.cornerRadius = 10
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
        return CGSize(width: collectionView.frame.width - 10, height: getEstimatedHeightFromDummyCell(indexPath))
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
