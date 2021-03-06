//
//  DBUtil.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import FirebaseDatabase
import FirebaseStorage
import Kingfisher
import RxSwift

class DBUtil {
    private init() {}
    static let shared = DBUtil()
    
    func loadChatTexts(completion: @escaping([Chat]) -> Void) {
        DB_CHATS.observe(.value) { snapShot in
            var loadedChats = [Chat]()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let data = snap.value as? [String: Any] else { return }
                
                guard let chatBody = data["chat"] as? String else { return }
                guard let chatUid = data["uid"] as? String else { return }
                guard let imgFileName = data["imgFileName"] as? String else { return }
                guard let timeStamp = data["timeStamp"] as? Int else { return }
                guard let deviceVendor = data["vendor"] as? String else { return }
                guard let cateogry = data["category"] as? String else { return }
                guard let commentCount = data["commentCount"] as? Int else { return }
                guard let reportCount = data["reportCount"] as? Int else { return }
                guard let FCMToken = data["FCMToken"] as? String else { return }
                let chat = Chat(chatBody: chatBody, uid: chatUid, imgFileName: imgFileName, timeStamp: timeStamp, vendor: deviceVendor, category: cateogry, commentCount: commentCount, reportCount: reportCount, FCMToken: FCMToken)
                print(chat.chatBody)
                loadedChats.append(chat)
            }
            completion(loadedChats)
        }
    }
    func loadCommentTexts(completion: @escaping([Comment]) -> Void) {
        DB_COMMENTS.observe(.value) { snapShot in
            var loadedComments = [Comment]()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let data = snap.value as? [String: Any] else { return }
                
                guard let uid = data["uid"] as? String else { return }
                guard let commentBody = data["commentBody"] as? String else { return }
                guard let targetChatUid = data["targetChatUid"] as? String else { return }
                guard let imgFileName = data["imgFileName"] as? String else { return }
                guard let timeStamp = data["timeStamp"] as? Int else { return }
                guard let deviceVendor = data["vendor"] as? String else { return }
                guard let reportCount = data["reportCount"] as? Int else { return }
                var comment: Comment?
                if data["isCommentToComment"] == nil {
                    comment = Comment(commentBody: commentBody, targetChatUid: targetChatUid, uid: uid, imgFileName: imgFileName, timeStamp: timeStamp, vendor: deviceVendor, reportCount: reportCount)
                } else {
                    guard let isCommentToComment = data["isCommentToComment"] as? String else { return }
                    guard let targetCommentUid = data["targetCommentUid"] as? String else { return }
                    comment = Comment(commentBody: commentBody, targetChatUid: targetChatUid, uid: uid, imgFileName: imgFileName, timeStamp: timeStamp, vendor: deviceVendor, isCommentToComment: isCommentToComment, targetCommentUid: targetCommentUid, reportCount: reportCount)
                }
                loadedComments.append(comment!)
            }
            completion(loadedComments)
        }
        
    }
    func loadChatImgsFromStorage(_ imgFileName: String, completion: @escaping(URL) -> Void) {
        STORAGE_USER_UPLOAD_IMGS.child(imgFileName).downloadURL { (url, error) in
            if error != nil {
                
            }
            guard let imgURL = url else { return }
            let cache = ImageCache.default
            do {
                let imgData = try Data(contentsOf: imgURL)
                guard let img = UIImage(data: imgData) else { return }
                cache.store(img, forKey: imgFileName)
                completion(imgURL)
            } catch {
                
            }
        }
    }
    func loadCommentImgsFromStorage(_ imgFileName: String, completion: @escaping(URL) -> Void) {
        STORAGE_COMMENT_IMGS.child(imgFileName).downloadURL { (url, error) in
            if error != nil {
                
            }
            guard let imgURL = url else { return }
            let cache = ImageCache.default
            do {
                let imgData = try Data(contentsOf: imgURL)
                guard let img = UIImage(data: imgData) else { return }
                cache.store(img, forKey: imgFileName)
                completion(imgURL)
            } catch {
                
            }
        }
    }
    func loadImgFromCache(_ imgFileName: String) -> UIImage?{
        let cache = ImageCache.default
        var image: UIImage?
        cache.retrieveImage(forKey: imgFileName) { result in
            switch result {
            case .success(let value):
                guard let img = value.image else { return }
                image = img
                break
            case .failure( _):
                break
            }
        }
        return image
    }
    func loadAllUserUploadImgs() -> Observable<UIImage> {
        return Observable.create { loadedImg in
            STORAGE_USER_UPLOAD_IMGS.listAll { (list, error) in
                var loadCount = 0
                if error != nil {
                    
                }
                totalLoadTargetCount += list.items.count
                if list.items.isEmpty {
                    loadedImg.onError(NoImgError.instance)
                }
                for item in list.items {
                    DispatchQueue.global(qos: .background).async {
                        item.downloadURL { (url, error) in
                            if error != nil {
                                
                            }
                            guard let imgURL = url else { return }
                            let cache = ImageCache.default
                            do {
                                guard let imgData = try? Data(contentsOf: imgURL) else { return }
                                guard let img = UIImage(data: imgData) else { return }
                                cache.store(img, forKey: item.name)
                                
                                nowLoadedTargetCount += 1
                                loadedImg.onNext(img)
                                print("현재 로딩된 수: \(nowLoadedTargetCount)")
                                
                                loadCount += 1
                                if loadCount == list.items.count {
                                    loadedImg.onCompleted()
                                }
                            }
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
    func loadAllCommentImgs() -> Observable<UIImage> {
        return Observable.create { loadedImg in
            var loadedImgCount = 0
            STORAGE_COMMENT_IMGS.listAll { (list, error) in
                if error != nil {
                    
                }
                totalLoadTargetCount += list.items.count
                if list.items.count == 0 {
                    if list.items.isEmpty {
                        loadedImg.onError(NoImgError.instance)
                    }
                }
                for item in list.items {
                    DispatchQueue.global(qos: .background).async {
                        item.downloadURL { (url, error) in
                            if error != nil {
                                
                            }
                            guard let imgURL = url else { return }
                            let cache = ImageCache.default
                            guard let imgData = try? Data(contentsOf: imgURL) else { return }
                            guard let img = UIImage(data: imgData) else { return }
                            cache.store(img, forKey: item.name)
                            
                            nowLoadedTargetCount += 1
                            print("현재 로딩된 수: \(nowLoadedTargetCount)")
                            loadedImg.onNext(img)
                            
                            loadedImgCount += 1
                            if loadedImgCount == list.items.count {
                                loadedImg.onCompleted()
                            }
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
    func initializeUserAlarm() {
        let value: [String: Any] = ["FCMToken": FCMToken, "alarm": 0]
        DB_USERS.child(FCMToken).updateChildValues(value)
    }
    func getUserData(completion: @escaping(User) -> Void) {
        var user: User?
        DB_USERS.child(FCMToken).observe(.value) { snapShot in
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else { return }
                guard let data = snap.value as? [String: Any] else { return }
                
                guard let FCMToken = data["FCMToken"] as? String else { return }
                guard let alarm = data["alarm"] as? Int else { return }
                
                user = User(FCMToken: FCMToken, alarm: alarm)
            }
        }
        completion(user!)
    }
    func updateUserAlarm(target FCMToken: String, count alarm: Int, completion:@escaping() -> Void) {
        DB_USERS.child(FCMToken).updateChildValues(["alarm": alarm]) { _, _ in
            completion()
        }
    }
    func getUserData(target FCMToken: String, completion: @escaping(User) -> Void) {
        DB_USERS.child(FCMToken).observe(.value) { snapShot in
            guard let data = snapShot.value as? [String: Any] else { return }
            guard let FCMToken = data["FCMToken"] as? String else { return }
            guard let alarm = data["alarm"] as? Int else { return }
            
            let user = User(FCMToken: FCMToken, alarm: alarm)
            completion(user)
        }
    }
}

class NoImgError: Error {
    static let instance = NoImgError()
    var msg = "img list empty"
}
