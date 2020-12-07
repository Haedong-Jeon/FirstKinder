//
//  HelperForGetData.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//
import Foundation
import RxSwift

extension LaunchController {    
    func getData() {
        for city in cities {
            if isParseStopSignOn {
                DispatchQueue.main.async {
                    self.kinderLabel.text = "초기화 에러: 최신 버전으로 재설치 해주세요."                    
                }
                return
            }
            let key = "b88e8eb18a894c84b9a20f1be9d079e8"
            let url = URL(string: "https://api.childcare.go.kr/mediate/rest/cpmsapi030/cpmsapi030/request?key=\(key)&arcode=\(city)&stcode=")
            guard let targetURL = url else { return }
            let xmlParser = XMLParser(contentsOf: targetURL)
            xmlParser?.delegate = self
            xmlParser?.parse()
            if xmlParser?.parserError != nil {
                DispatchQueue.global(qos: .background).async {
                    //중간에 받아 오지 못하는 데이터가 있더라도 자연스럽게 넘어간다.
                    //오류가 났을 때 loadCount를 1 올리지 않으면, 런치 스크린에서 다음 화면으로 넘어가지 않게 된다.
                    self.loadCount += 1
                }
            }
        }
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "crname" {
            tagKind = TagKind.title
        } else if elementName == "crstatusname" {
            tagKind = TagKind.status
        } else if elementName == "sidoname" {
            tagKind = TagKind.city
        } else if elementName == "sigunguname" {
            tagKind = TagKind.gu
        } else if elementName == "zipcode" {
            tagKind = TagKind.zipcode
        } else if elementName == "craddr" {
            tagKind = TagKind.craddr
        } else if elementName == "crtelno" {
            tagKind = TagKind.crtelno
        } else if elementName == "la" {
            tagKind = TagKind.la
        } else if elementName == "lo" {
            tagKind = TagKind.lo
        } else if elementName == "crcapat" {
            tagKind = TagKind.crcapat
        } else if elementName == "crchcnt" {
            tagKind = TagKind.crchcnt
        } else if elementName == "crcargbname" {
            tagKind = TagKind.crcargbname
        } else if elementName == "chcrtescnt" {
            tagKind = TagKind.chcrtescnt
        } else if elementName == "nrtrroomcnt" {
            tagKind = TagKind.nrtrroomcnt
        } else if elementName == "nrtrroomsize" {
            tagKind = TagKind.nrtrroomsize
        } else if elementName == "crhome" {
            tagKind = TagKind.crhome
        } else {
            tagKind = TagKind.others
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        makeKinderObservable(elementName)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                if $0.isOn != "폐지" {
                    kinders.append($0)
                }
                self.kinderLabel.text = "데이터 확인..." + $0.title
            },onCompleted: {
                let transition = CATransition()
                transition.duration = 0.3
                transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                transition.type = .fade
                
                self.navigationController?.view.layer.add(transition, forKey: nil)
                self.navigationController?.pushViewController(MainController(), animated: false)
                
            }).disposed(by: self.disposeBag)
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch tagKind {
        case .title:
            kinder.title = string
        case .status:
            kinder.isOn = string
        case .city:
            kinder.city = string
        case .gu:
            kinder.gu = string
        case .zipcode:
            kinder.zipcode = string
        case .craddr:
            kinder.craddr = string
        case .crtelno:
            kinder.tel = string
        case .la:
            kinder.la = string
        case .lo:
            kinder.lo = string
        case .crcapat:
            kinder.totalNumOfChild = string
        case .crchcnt:
            kinder.currentNumOfChild = string
        case .crcargbname:
            kinder.isCarAvailable = string
        case .chcrtescnt:
            kinder.numOfTeachr = string
        case .nrtrroomcnt:
            kinder.numOfRoom = string
        case .nrtrroomsize:
            kinder.sizeOfRoom = string
        case .crhome:
            kinder.web = string
        case .others:
            return
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("ERROR in parsing xml - \(parseError)")
    }
    func makeKinderObservable(_ tag: String) -> Observable<Kinder> {
        return Observable.create { observer in
            if tag == "item" {
                observer.onNext(self.kinder)
                DispatchQueue.main.async {
                    self.progressBar.progress += 0.0001
                }
            } else if tag == "response" {
                DispatchQueue.main.async {
                    //한 지역의 데이터를 전부 받을 때마다 loadCount를 1 올린다.
                    self.loadCount += 1
                    if self.loadCount >= self.cities.count {
                        //전체 지역 수와 loadCount 수가 같아지면 로딩 완료.
                        self.progressBar.progress = 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            //로딩 바가 꽉찬걸 보여줄려고 일부러 1초 뒤에 화면 전환.
                            observer.onCompleted()
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
}
