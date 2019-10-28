//
//  BoolTransform.swift
//  ParkingFriends
//
//  Created by misco on 2019/10/15.
//  Copyright © 2019 Hancom Mobility. All rights reserved.
//

import ObjectMapper

/// Transforms value of type Any to Bool. Tries to typecast if possible.
public class BoolTransform: TransformType {
    public typealias Object = Bool
    public typealias JSON = Bool
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Object? {
        if value == nil {
            return nil
        } else if let bool = value as? Bool {
            return bool
        } else if let int = value as? Int {
            return (int != 0)
        } else if let double = value as? Double {
            return (double != 0)
        } else if let string = value as? String {
            if let boolean = Bool(string) {
                return boolean
            } else {
                let boolean = string as NSString
                return boolean.boolValue
            }
        } else if let number = value as? NSNumber {
            return number.boolValue
        } else {
            #if DEBUG
            print("Can not cast value \(value!) of type \(type(of: value!)) to type \(Object.self)")
            #endif
            
            return nil
        }
    }
    
    public func transformToJSON(_ value: Object?) -> JSON? {
        return value
    }
}
