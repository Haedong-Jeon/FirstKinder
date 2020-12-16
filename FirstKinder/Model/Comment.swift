//
//  Comment.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/11.
//

import Foundation

struct Comment {
    var commentBody: String
    var targetChatUid: String
    var uid: String
    var imgFileName: String
    var timeStamp: Int
    var vendor: String
    var isCommentToComment: String?
    var targetCommentUid: String?
    var reportCount: Int
}
var comments = [Comment]()


