//
//  UUIDUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import Foundation

class UUIDUtility {
    
    public static func getUUID() -> String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
    
}
