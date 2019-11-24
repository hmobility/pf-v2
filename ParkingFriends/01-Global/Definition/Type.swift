//
//  Type.swift
//  ParkingFriends
//
//  Created by PlankFish on 2019/10/25.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import Foundation

enum Language:String {
    case korean = "ko"
    case english = "en"
}

enum HttpMethod:String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum ContentType:String {
    case withdraw = "WITHDRAW"
    case suggest_type = "SUGGEST_TYPE"
    case faq = "FAQ"
    case product_type = "PRODUCT_TYPE"
}

enum TermsType: Int {
    case usage, personal_info, location_service, third_party_info, marketing_info
    case none
}

enum ResponseCodeType: String {
    case success = "0000"
    case not_found = "1404"
    case unknown = ""
}

typealias Params = [String : Any]
