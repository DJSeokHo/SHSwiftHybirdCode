//
//  NotificationUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/12.
//

import Foundation

class NotificationUtility {
    
    public static func post(name: String, userInfo: [AnyHashable : Any]? = nil, object: Any? = nil) {
      
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name), object: object, userInfo: userInfo)
    }
    
    public static func addObserver(name: String, observer: Any, selector: Selector, object: Any? = nil) {
        
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(rawValue: name), object: object)
        
    }
    
    public static func removeAllObserver(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    public static func getNotificationResult(_ notification: Notification, key: String) -> Any {
        
        return notification.userInfo?[key] ?? ""
        
    }
    
}
