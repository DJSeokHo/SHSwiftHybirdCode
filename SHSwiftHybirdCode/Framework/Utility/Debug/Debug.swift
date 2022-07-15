//
//  Debug.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import Foundation

class ILog {
    
    public static func debug(tag: String, content: Any) {
        
        var name = tag
        
        if tag.contains("/") {
            let arraySubstrings: [Substring] = tag.split(separator: "/")
            
            let arrayStrings: [String] = arraySubstrings.compactMap {
                (item) -> String in
                        
               return "\(item)"
            }
            
            name = arrayStrings.last!
        }
        
        print("ILog ======> \(name): \(content)")
    }
    
}
