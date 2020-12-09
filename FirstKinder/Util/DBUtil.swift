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
                let chat = Chat(chatBody: chatBody, uid: chatUid, imgFileName: imgFileName, timeStamp: timeStamp, vendor: deviceVendor)
                loadedChats.append(chat)
            }
            completion(loadedChats)
        }
    }
    func loadChatImgsFromStorage(_ imgFileName: String, completion: @escaping(URL) -> Void) {
        STORAGE_USER_UPLOAD_IMGS.child(imgFileName).downloadURL { (url, error) in
            if error != nil {
                print("error in download img \(error)")
            }
            guard let imgURL = url else { return }
            completion(imgURL)
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
}
