//
//  DetailHelperForSaveMyKinder.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/03.
//

import UIKit

extension KinderDetailController {
    func saveMyKinder(completion: ()-> Void) {
        myKinders.append(self.kinder)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(myKinders), forKey: "myKinders")
        completion()
    }
    func deleteFromMyKinder(completion: ()-> Void) {
        guard let index = myKinders.firstIndex(where: {
            $0.title == self.kinder.title && $0.craddr == self.kinder.craddr && $0.tel == self.kinder.tel
        }) else {
            return
        }
        myKinders.remove(at: index)
        UserDefaults.standard.set(try? PropertyListEncoder().encode(myKinders), forKey: "myKinders")
        completion()
    }
}
