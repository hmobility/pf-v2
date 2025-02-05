//
//  APIs.swift
//  ParkingFriends
//
//  Created by mkjwa on 2019/10/15.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import Foundation
import Alamofire

public enum AuthEmailType:String {
    case phone = "PHONE"
    case password = "PASSWORD"
}

public enum AuthAccountType:String {
    case id = "ID"
    case email = "EMAIL"
    case nickname = "NICKNAME"
}

struct AuthAPI:BaseAPI {
    static func refresh_token(_ refreshToken:String, httpMethod:HttpMethod = .get, security:APIAuthType = .none) -> RestURL {
        let query:Params = ["refreshToken": refreshToken]
        let url = build(host:host, endpoint:"/auth/refresh-token", query: query)
        return (httpMethod, url, security, nil)
    }
    // 로그인
    static func login(username:String, password:String, httpMethod:HttpMethod = .post, security:APIAuthType = .none) -> RestURL {
        let params:Params = ["username": username, "password": password]
        let url = build(host:host, endpoint:"/auth/login", query: nil)
        return (httpMethod, url, security, params)
    }
    
    // 로그아웃
    static func logout(httpMethod:HttpMethod = .post, auth:APIAuthType = .serviceKey) -> RestURL  {
        let url = build(host:host, endpoint:"/auth/logout", query: nil)
        return (httpMethod, url, auth, nil)
    }
    
    // 휴대폰 OTP 전송
    static func otp(phoneNumber:String, httpMethod:HttpMethod = .post, auth:APIAuthType = .serviceKey) -> RestURL  {
        let params:Params = ["phoneNumber": phoneNumber]
        let url = build(host:host, endpoint:"/auth/otp", query: nil)
        return (httpMethod, url, auth, params)
    }
    
    // 휴대폰 OTP 확인
    static func otp_check(phoneNumber:String, otp:String, otpId:Int, httpMethod:HttpMethod = .post, auth:APIAuthType = .serviceKey) -> RestURL  {
        let params:Params = ["phoneNumber": phoneNumber, "otp": otp, "otpId": otpId]
        let url = build(host:host, endpoint:"/auth/otp/check", query: nil)
        return (httpMethod, url, auth, params)
    }
    
    // 아이디/비밀번호 찾기 이메일 전송
    static func email(type:AuthEmailType, email:String, httpMethod:HttpMethod = .post, auth:APIAuthType = .serviceKey) -> RestURL  {
        let params:Params = ["type": type.rawValue, "email": email]
        let url = build(host:host, endpoint:"/auth/email", query: nil)
        return (httpMethod, url, auth, params)
    }
    
    // 아이디 변경
    static func username(emailOtp:String, phoneNumber:String, newPhoneNumber:String, otp:String, otpId:String, httpMethod:HttpMethod = .post, auth:APIAuthType = .serviceKey) -> RestURL  {
        let params:Params = ["emailOtp": emailOtp, "phoneNumber": phoneNumber, "newPhoneNumber":newPhoneNumber, "otp":otp, "otpId":otpId]
        let url = build(host:host, endpoint:"/auth/username", query: nil)
        return (httpMethod, url, auth, params)
    }
    
    // 비밀번호 변경
    static func password(emailOtp:String, username:String, password:String, httpMethod:HttpMethod = .post, auth:APIAuthType = .serviceKey) -> RestURL  {
        let params:Params = ["emailOtp": emailOtp, "username": username, "password":password]
        let url = build(host:host, endpoint:"/auth/password", query: nil)
        return (httpMethod, url, auth, params)
    }
    
    // 중복확인 (아이디, 이메일, 닉네임)
    static func exist(type:AuthAccountType, value:String, httpMethod:HttpMethod = .get, auth:APIAuthType = .serviceKey) -> RestURL  {
        let params:Params = ["type": type.rawValue, "value": value]
        let url = build(host:host, endpoint:"/auth/password", query: nil)
        return (httpMethod, url, auth, params)
    }
    
    // 기존 회원 가입 여부
    static func check_old_member(phoneNumber:String, httpMethod:HttpMethod = .get, auth:APIAuthType = .serviceKey) -> RestURL  {
        let params:Params = ["phoneNumber": phoneNumber]
        let url = build(host:host, endpoint:"/auth/password", query: nil)
        return (httpMethod, url, auth, params)
    }
}
