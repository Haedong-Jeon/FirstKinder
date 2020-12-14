//
//  DBUtil.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/08.
//

import FirebaseDatabase
import FirebaseStorage
import Kingfisher

class DBUtil {
    private init() {}
    static let shared = DBUtil()
    
    func loadChatTexts(completion: @escaping([Chat]) -> Void) {
        DispatchQueue.global(qos: .background).async {
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
                    let chat = Chat(chatBody: chatBody, uid: chatUid, imgFileName: imgFileName, timeStamp: timeStamp, vendor: deviceVendor, category: cateogry, commentCount: commentCount, reportCount: reportCount)
                    loadedChats.append(chat)
                }
                completion(loadedChats)
            }
        }
    }
    func loadCommentTexts(completion: @escaping([Comment]) -> Void) {
        DispatchQueue.global(qos: .background).async {
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
                    let comment = Comment(commentBody: commentBody, targetChatUid: targetChatUid, uid: uid, imgFileName: imgFileName, timeStamp: timeStamp, vendor: deviceVendor)
                    loadedComments.append(comment)
                }
                completion(loadedComments)
            }
        }
    }
    func loadChatImgsFromStorage(_ imgFileName: String, completion: @escaping(URL) -> Void) {
        DispatchQueue.global(qos: .background).async {
            STORAGE_USER_UPLOAD_IMGS.child(imgFileName).downloadURL { (url, error) in
                if error != nil {
                    print("error in download img \(error)")
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
    }
    func loadCommentImgsFromStorage(_ imgFileName: String, completion: @escaping(URL) -> Void) {
        DispatchQueue.global(qos: .background).async {
            STORAGE_COMMENT_IMGS.child(imgFileName).downloadURL { (url, error) in
                if error != nil {
                    print("error in download img \(error)")
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
    func loadAllImg() {
        DispatchQueue.global(qos: .background).async { [self] in
            loadAllUserUploadImgs()
            loadAllCommentImgs()
        }
    }
    func loadAllUserUploadImgs() {
        STORAGE_USER_UPLOAD_IMGS.listAll { (list, error) in
            if error != nil {
                print("error in load all imgs \(error)")
            }
            for item in list.items {
                DispatchQueue.global(qos: .background).async {
                    item.downloadURL { (url, error) in
                        if error != nil {
                            print("error in download img \(error)")
                        }
                        guard let imgURL = url else { return }
                        let cache = ImageCache.default
                        do {
                            let imgData = try Data(contentsOf: imgURL)
                            guard let img = UIImage(data: imgData) else { return }
                            cache.store(img, forKey: item.name)
                            print(item.name)
                        } catch {
                            
                        }
                    }
                }
            }
        }
    }
    func loadAllCommentImgs() {
        STORAGE_COMMENT_IMGS.listAll { (list, error) in
            if error != nil {
                print("error in load all imgs \(error)")
            }
            for item in list.items {
                DispatchQueue.global(qos: .background).async {
                    item.downloadURL { (url, error) in
                        if error != nil {
                            print("error in download img \(error)")
                        }
                        guard let imgURL = url else { return }
                        let cache = ImageCache.default
                        do {
                            let imgData = try Data(contentsOf: imgURL)
                            guard let img = UIImage(data: imgData) else { return }
                            cache.store(img, forKey: item.name)
                            print(item.name)
                            
                        } catch {
                            
                        }
                    }
                }
            }
        }
    }
    
}
