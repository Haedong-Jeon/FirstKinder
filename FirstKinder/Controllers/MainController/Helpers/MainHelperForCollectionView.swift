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
        cell.kinderTitleTextView.text = nowShowingKinders[indexPath.row].title
        cell.kinderPositionTextView.text = nowShowingKinders[indexPath.row].craddr
        cell.kinderIsOnTextview.text = nowShowingKinders[indexPath.row].isOn
        
        if cell.kinderIsOnTextview.text == "정상" {
            cell.kinderIsOnTextview.textColor = .systemBlue
            cell.faceIconImgView.image = #imageLiteral(resourceName: "smileFace")
        } else if cell.kinderIsOnTextview.text == "폐지" {
            cell.kinderIsOnTextview.textColor = .systemPink
            cell.faceIconImgView.image = #imageLiteral(resourceName: "sadFace")
        } else if cell.kinderIsOnTextview.text == "휴지" {
            cell.kinderIsOnTextview.textColor = .systemYellow
            cell.faceIconImgView.image = #imageLiteral(resourceName: "sadFace")
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowShowingKinders.count
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
