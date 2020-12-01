//
//  MainHelperForCollectionView.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/01.
//

import UIKit

extension MainController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as? KinderCell else {
            return UICollectionViewCell()
        }
        cell.kinderTitleLabel.text = nowShowingKinders[indexPath.row].title
        cell.kinderPositionLabel.text = nowShowingKinders[indexPath.row].craddr
        cell.kinderIsOnLabel.text = nowShowingKinders[indexPath.row].isOn
        
        if cell.kinderIsOnLabel.text == "정상" {
            cell.kinderIsOnLabel.textColor = .systemBlue
            cell.faceIconImgView.image = #imageLiteral(resourceName: "smileFace")
        } else if cell.kinderIsOnLabel.text == "폐지" {
            cell.kinderIsOnLabel.textColor = .systemPink
            cell.faceIconImgView.image = #imageLiteral(resourceName: "sadFace")
        } else if cell.kinderIsOnLabel.text == "휴지" {
            cell.kinderIsOnLabel.textColor = .systemYellow
            cell.faceIconImgView.image = #imageLiteral(resourceName: "sadFace")
        } else if cell.kinderIsOnLabel.text == "재개" {
            cell.kinderIsOnLabel.textColor = .systemBlue
            cell.faceIconImgView.image = #imageLiteral(resourceName: "smileFace")
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowShowingKinders.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let kinder = nowShowingKinders[indexPath.row]
        let detailViewController = DetailController()
        detailViewController.kinder = kinder
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 95)
    }
}
