//
//  SOAOOExampleViewModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/07.
//

import Foundation
import SwiftUI

class SOAOOExampleViewModel: ObservableObject {
    
    var type: String
    var id: Int
    
    @Published
    var count = 0
    
    init(type: String) {
        
        self.type = type
        self.id = Int.random(in: 0...1000)
        ILog.debug(tag: #file, content: "type:\(type) id:\(id) init")
        
    }
    
    deinit {
        ILog.debug(tag: #file, content: "type:\(type) id:\(id) deinit")
    }
    
}
