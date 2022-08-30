//
//  EnvironmentObjectExampleModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/29.
//

import Foundation
import SwiftUI


class EnvironmentObjectExampleClassModel: ObservableObject {
    
    static let instance = EnvironmentObjectExampleClassModel()
        
    private init() {}
    
    @Published
    var name: String = ""
    
    @Published
    var number: Int = 0
    
    func initData(name: String) {
        self.name = name
    }
}
