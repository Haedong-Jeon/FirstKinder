# 퍼스트 킨더 First Kinder
<img src="https://user-images.githubusercontent.com/53557016/102726584-51e94f00-4363-11eb-9a08-cd05f2abc632.png" height = 500 width = 250/> <img src="https://user-images.githubusercontent.com/53557016/102726586-557cd600-4363-11eb-84ac-c1f74bc048c7.png" height = 500 width = 250/> <img src="https://user-images.githubusercontent.com/53557016/102726590-57df3000-4363-11eb-931f-4be87f0a6b9b.png" height = 500 width = 250/>              
<img src="https://user-images.githubusercontent.com/53557016/102726587-56ae0300-4363-11eb-9000-e2d5c5559ec2.png" height = 500 width = 250/>
<img src="https://user-images.githubusercontent.com/53557016/102726589-57469980-4363-11eb-9aa4-e06e6f2bd87b.png" height=500 width = 250/>           
            
출시 여부: 출시 ✅         
광고 게재 여부: ❌ - 비영리 앱     
앱스토어 주소: https://apps.apple.com/kr/app/%ED%8D%BC%EC%8A%A4%ED%8A%B8-%ED%82%A8%EB%8D%94/id1542758485    
      
초보 부모님이 어린이집을 선택할 때 도움을 주고자 제작된 앱입니다.      
* 서울의 어린이집 정보를 모아 사용자에게 제공합니다.     
* 다른 사람들과 정보를 공유할 수 있습니다. 차단과 신고 기능이 있습니다. 댓글이 달리면 푸시 알림이 갑니다.
* GPS 기반, 현재 위치 주변에 어떤 어린이집이 있는지 보여줍니다.    
    
## 사용된 기술
RxSwift, 구글 파이어베이스 서버, DispatchQueue를 이용한 비동기 프로그래밍, xml파싱

## 🎬간단 작동 영상(유튜브)
https://youtu.be/46RczF1coRs


## 🚪런치 스크린    
<img src ="https://user-images.githubusercontent.com/53557016/102679198-45dd8000-41f1-11eb-83d9-fe00173ce2bb.gif" height=600 width=300/>    
런치 스크린에선 어린이집 데이터와 사용자 업로드 이미지들을 불러옵니다. 이미지를 불러오는데엔 시간이 꽤 걸립니다.        

런치 스크린에서 어느정도 미리 불러오면 사용자가 더 쾌적하게 앱을 사용할 수 있습니다.
    
```swift
func loadUploadUserImgs() {
      DBUtil.shared.loadAllUserUploadImgs().subscribe(onNext: { _ in
                  self.fillUpProgressBar()
            },onError: { error in
            if error is NoImgError {
                  self.userUploadImgLoadComplete = true
            }
      }, onCompleted: {
            self.userUploadImgLoadComplete = true
      }).disposed(by: self.disposeBag)
}
```
이미지를 불러오는 코드입니다. 이미지 로딩이 완료되면 userUploadImgLoadComplete를 true로 만듭니다.         
서버에 업로드 된 이미지가 하나도 없는 경우, 그러니까 NoImgError가 발생한 경우도 같습니다.      
          
__로드할 이미지가 없다는건 곧 로드가 완료 됐다는 말과 같으니까요.__        
       
```swift
func makeKinderObservable(_ tag: String) -> Observable<Kinder> {
      return Observable.create { observer in
            if tag == "item" {
                  observer.onNext(self.kinder)
            } else if tag == "response" {
                  observer.onCompleted()
            }
            return Disposables.create()
      }
}
```
        
어린이집 정보를 받습니다. 보육 정보 공개 API를 이용했습니다. xml형태로 제공됩니다. xml 데이터는 지역별 묶음으로 제공됩니다.       
그러니까 item태그는 어린이집 하나를 구별하고, response태그는 하나의 지역을 구별합니다.        
           
item 태그를 만나면 onNext로 넘겨주고, response 태그를 만나면 다음 지역으로 넘어갑니다.    
로딩이 완료되면 메인 페이지로 넘어갑니다.    
      
## 😋메인    
<img src = "https://user-images.githubusercontent.com/53557016/102679862-4b899480-41f6-11eb-92e7-1b4b92689708.gif" height=600 width=300/>    
      
```swift
func setTabs() {
      let kinderListController = ListController(collectionViewLayout: UICollectionViewFlowLayout())
      kinderListController.tabBarItem.image = #imageLiteral(resourceName: "to-do-list (1)")
      kinderListController.tabBarItem.title = "어린이집 목록"
        
      let nearKinderController = NearKinderController()
      nearKinderController.tabBarItem.image = #imageLiteral(resourceName: "maps-and-flags (1)")
      nearKinderController.tabBarItem.title = "근처 어린이집"
        
      let parentsChatController = ChatController(collectionViewLayout: UICollectionViewFlowLayout())
      parentsChatController.tabBarItem.image = #imageLiteral(resourceName: "chat-bubbles-with-ellipsis (1)")
      parentsChatController.tabBarItem.title = "이야기"
        
      let myKindersController = MyKindersController(collectionViewLayout: UICollectionViewFlowLayout())
      myKindersController.tabBarItem.image = #imageLiteral(resourceName: "like (2)")
      myKindersController.tabBarItem.title = "관심 어린이집"
        
      let controllers = [kinderListController, nearKinderController, parentsChatController, myKindersController]
      viewControllers = controllers.map({UINavigationController(rootViewController: $0)})//탭안의 뷰컨트롤러들에게 네비 바 붙이기.
      tabBar.tintColor = #colorLiteral(red: 0.1884440184, green: 0.1871832013, blue: 0.2520470917, alpha: 1)
      tabBar.isTranslucent = false
}
```
메인 컨트롤러는 각 탭을 관리하는 탭 컨트롤러 입니다.

## 📑어린이집 목록        
<img src = "https://user-images.githubusercontent.com/53557016/102680434-762a1c00-41fb-11eb-9158-c685632d7a41.gif" height=600 width=300/> <img src = "https://user-images.githubusercontent.com/53557016/102680099-bcca4700-41f8-11eb-933b-4a007f39d5e9.gif" height=600 width=300/>

## 💬 이야기
<img src = "https://user-images.githubusercontent.com/53557016/102704294-eba9f100-42bc-11eb-8eaf-971d493bc353.png" height = 600 width = 300/><img src = "https://user-images.githubusercontent.com/53557016/102704298-f06ea500-42bc-11eb-8239-b7099e235e5f.png" height=600 width=300/><img src = "https://user-images.githubusercontent.com/53557016/102704460-fa91a300-42be-11eb-8946-66148c47e08e.png" height = 600 width = 300>

### 동적 셀 사이즈
```swift
func getEstimatedHeightFromDummyCell(_ indexPath: IndexPath) -> CGFloat{
      let width = view.frame.width - 10
      let estimatedHeight: CGFloat = 800.0
      let dummyCell = ChatCell(frame: CGRect(x: 0, y: 0, width: width, height: estimatedHeight))
      (...생략...)
      dummyCell.chatBodyLabel.text = nowChats[indexPath.row].chatBody
      if nowChats[indexPath.row].imgFileName == "NO IMG" {
            drawCellWithoutImg(dummyCell)
      } else {
            drawCellWithImg(dummyCell, indexPath)
      }
      dummyCell.layoutIfNeeded()
      let estimateSize = dummyCell.systemLayoutSizeFitting(CGSize(width: width, height: estimatedHeight))
      return estimateSize.height
}
```
사용자가 작성한 게시글의 길이, 이미지 유무에 따라 셀이 크기가 동적으로 변하도록 했습니다. DummyCell 기법을 사용했습니다.       
아주 큰 사이즈의 더미 셀에 데이터를 넣어본 후, 필요 없는 공간은 삭제하고 실제로 얼마나 공간이 필요한지 가늠해보는 방식입니다.
### 대댓글 구현
```swift
func commentToCommentControl() {
      if self.thisComments.isEmpty { return }
        
      self.commentToComments = comments
                                    .filter({$0.isCommentToComment != nil})
                                    .sorted(by: {$0.timeStamp < $1.timeStamp})

      if self.commentToComments.isEmpty { return }
      var mergedComments = [Comment]()
      for i in 0 ... thisComments.count - 1 {
            var tempCmts = [Comment]()
            mergedComments.append(thisComments[i])
            commentToComments.forEach({
                  if mergedComments.last!.uid == $0.targetCommentUid {
                        tempCmts.append($0)
                  }
            })
            mergedComments += tempCmts
            tempCmts.removeAll()
      }
      thisComments = mergedComments
}
```
각 댓글은 자신이 일반 댓글인지, 대댓글인지, 대댓글이라면 그 대상 댓글은 뭔지 정보를 포함하고 있습니다.      
일반 댓글 배열, 대댓글 배열, 합쳐질 댓글 배열 셋을 따로 준비 했습니다.    
    
일반 댓글 하나를 합쳐질 댓글 배열에 옮기고, 반복문을 통해 그 댓글의 대댓글을 찾습니다. 찾은 대댓글들을 합쳐질 댓글 배열에 넣습니다.       
그러면 댓글 하나와 그 댓글에대한 대댓글들이 순서대로 합쳐질 댓글 배열에 들어가게 됩니다.
