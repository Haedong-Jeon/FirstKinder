//
//  DetailHelperForSaveMyKinder.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit

extension DetailController {
    func saveMyKinder(completion: ()-> Void) {
        myKinders.append(self.kinder)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(myKinders), forKey: "myKinders")
        completion()
    }
}
