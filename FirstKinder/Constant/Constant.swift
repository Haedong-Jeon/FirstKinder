//
//  Constant.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/02.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit

let loadFinishProgress: Float = 0.95
let chatPlaceHoldText = "타인에게 상처를 주는 말은 하지 말아요 :)\n마음이 따뜻해지는 말을 나눠요.❤︎"

let DB_ROOT = Database.database().reference()
let DB_CHATS = DB_ROOT.child("chats")
let DB_COMMENTS = DB_ROOT.child("comments")
let DB_INFO = DB_ROOT.child("info")

let STORAGE = Storage.storage().reference()
let STORAGE_USER_UPLOAD_IMGS = STORAGE.child("userUploadImgs")
let STORAGE_COMMENT_IMGS = STORAGE.child("commentImgs")

var blockedUserVendors = [String]()
var blockedUserReasons = [String]()
var blockedReasonCategories = [String]()
var reportedChatList = [String]()
var commentReloader = false


var cities = ["11680", "11740", "11305", "11500", "11620", "11215", "11530", "11545", "11350", "11320", "11230", "11590", "11440", "11410", "11650", "11200", "11290", "11710", "11470", "11560", "11170", "11380", "11110", "11140", "11260"]

var cityNames = [
    "강남","강동", "강북", "강서", "관악", "광진", "구로", "금천", "노원", "도봉", "동대문", "동작", "마포", "서대문", "서초", "성동", "성북", "송파", "양천", "영등포", "용산", "은평", "종로", "중구", "중랑구"
]
