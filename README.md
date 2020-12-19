# 퍼스트 킨더 First Kinder
앱스토어 주소: https://apps.apple.com/kr/app/%ED%8D%BC%EC%8A%A4%ED%8A%B8-%ED%82%A8%EB%8D%94/id1542758485    
      
초보 부모님이 어린이집을 선택할 때 도움을 주고자 제작된 앱입니다.      
* 서울의 어린이집 정보를 모아 사용자에게 제공합니다.     
* 다른 사람들과 정보를 공유할 수 있습니다.       
* GPS 기반, 현재 위치 주변에 어떤 어린이집이 있는지 보여줍니다.    
    
## 사용된 기술
RxSwift, 구글 파이어베이스 서버, DispatchQueue를 이용한 비동기 프로그래밍, xml파싱

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
그러니까 <item>태그는 어린이집 하나를 구별하고, <response>태그는 하나의 지역을 구별합니다.        
           
item 태그를 만나면 onNext로 넘겨주고, response 태그를 만나면 다음 지역으로 넘어갑니다.    
로딩이 완료되면 메인 페이지로 넘어갑니다.    
      
## 😋메인
