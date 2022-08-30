//
//  SingletonExample.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/29.
//

import Foundation

class SingletonExample {
    
    // for async need a static func to call the method of singleton object
    static func methodWithAsync() async -> Bool {
        return await SingletonExample.instance.methodWithAsync()
    }
    
    static func justMethod() {
        SingletonExample.instance.justMethod()
    }
    
    static let instance = SingletonExample()
    
    private init() {}
    
    var token = ""

    func methodWithAsync() async -> Bool {

        return token != ""
    }
    
    func justMethod() {
        ILog.debug(tag: #file, content: "justMethod")
    }
    
}
