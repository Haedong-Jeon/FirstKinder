//
//  Constant.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/02.
//

import Foundation
import FirebaseDatabase

let loadFinishProgress: Float = 0.95
let chatPlaceHoldText = "즐겁게 육아에 관한 이야기를 나눠요 :)"
let DB_ROOT = Database.database().reference()
let DB_CHATS = DB_ROOT.child("chats")
