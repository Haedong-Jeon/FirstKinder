//
//  HelperForGetData.swift
//  FirstKinder
//
//  Created by 전해동 on 2020/11/30.
//

import Foundation

extension LaunchController {
    func getData() {
        let key = "b88e8eb18a894c84b9a20f1be9d079e8"
        let url = URL(string: "https://api.childcare.go.kr/mediate/rest/cpmsapi030/cpmsapi030/request?key=\(key)&arcode=11380&stcode=")
        guard let targetURL = url else { return }
        var xmlParser = XMLParser(contentsOf: targetURL)
        xmlParser?.delegate = self
        xmlParser?.parse()
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
        } else {
            tagKind = TagKind.others
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            kinders.append(kinder)
        }
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
        case .others:
            return
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        
    }
}
