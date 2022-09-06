//
//  ThreadUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/06.
//

import Foundation

class ThreadUtility {
    
    public static func startThread(runnable: @escaping () -> Void) {
        DispatchQueue.global().async {
            runnable()
        }
    }
    
    public static func startUIThread(runnable: @escaping () -> Void, afterSeconds seconds: Double) {
        
        Thread.sleep(forTimeInterval: seconds)
        
        DispatchQueue.main.async {
            runnable()
        }
    }
    
}
