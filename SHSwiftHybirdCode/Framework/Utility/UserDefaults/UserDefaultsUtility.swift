//
//  UserDefaultsUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/14.
//

import Foundation

class UserDefaultsUtility {
    
    static func save(key: String, andValue value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func save(key: String, andValue value: Int) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func save(key: String, andValue value: Float) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func save(key: String, andValue value: Double) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func save(key: String, andValue value: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    static func get(key: String) async -> String {
        
        await withUnsafeContinuation { continuation in
            
            DispatchQueue.global().async {
                
                ILog.debug(tag: #file, content: "get \(Thread.current)")
                
                let defaults = UserDefaults.standard
                continuation.resume(returning: defaults.string(forKey: key) ?? "")
            }
        }
    }
    
    static func get(key: String) -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: key)
    }
    
    static func get(key: String) -> Float {
        let defaults = UserDefaults.standard
        return defaults.float(forKey: key)
    }
    
    static func get(key: String) -> Double {
        let defaults = UserDefaults.standard
        return defaults.double(forKey: key)
    }
    
    static func get(key: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
}
