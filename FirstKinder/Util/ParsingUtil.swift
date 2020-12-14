//
//  ParsingUtil.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/12/14.
//

import UIKit
import RxSwift

class ParsingUtil: NSObject, XMLParserDelegate {
    
    var kinder = Kinder()
    var disposeBag = DisposeBag()
    var tagKind = TagKind.title
    var isParseStopSignOn = false
    var loadedCityCount = 0
    static let shared = ParsingUtil()
    
    func getData(cityCode: String) -> Error? {
        var errorCode: Error?
        if isParseStopSignOn {
            return errorCode
        }
        let key = "b88e8eb18a894c84b9a20f1be9d079e8"
        let url = URL(string: "https://api.childcare.go.kr/mediate/rest/cpmsapi030/cpmsapi030/request?key=\(key)&arcode=\(cityCode)&stcode=")
        guard let targetURL = url else { return errorCode }
        let xmlParser = XMLParser(contentsOf: targetURL)
        xmlParser?.delegate = self
        xmlParser?.parse()
        if xmlParser?.parserError != nil {
            DispatchQueue.global(qos: .background).async {
                errorCode = xmlParser?.parserError
            }
        }
        return errorCode
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
                    print($0.title)
                }
            },onCompleted: {
                if self.loadedCityCount < cities.count - 1 {
                    self.loadedCityCount += 1
                }
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
            } else if tag == "response" {
                DispatchQueue.main.async {
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}



