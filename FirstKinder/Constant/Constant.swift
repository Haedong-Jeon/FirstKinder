//
//  Constant.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/02.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let loadFinishProgress: Float = 0.95
let chatPlaceHoldText = "타인에게 상처를 주는 말은 하지 말아요 :)\n마음이 따뜻해지는 말을 나눠요.❤︎"
let DB_ROOT = Database.database().reference()
let DB_CHATS = DB_ROOT.child("chats")

let STORAGE = Storage.storage().reference()
let STORAGE_USER_UPLOAD_IMGS = STORAGE.child("userUploadImgs")

var blockedUserVendors = [String]()
var blockedUserReasons = [String]()
var blockedReasonCategories = [String]()

