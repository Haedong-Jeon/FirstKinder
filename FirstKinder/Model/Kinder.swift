//
//  Kinder.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import UIKit

struct Kinder: Codable {
    var isOn = "운영"
    var title = ""
    var city = ""
    var gu = ""
    var la = ""
    var lo = ""
    var tel = ""
    var craddr = ""
    var zipcode = ""
    var totalNumOfChild = ""//정원
    var currentNumOfChild = ""//현원
    var isCarAvailable = ""//통학 차량 운영 여부
    var numOfTeachr = ""
    var sizeOfRoom = ""
    var numOfRoom = ""
    var web = ""
}
var kinders = [Kinder]()
var myKinders = [Kinder]()
