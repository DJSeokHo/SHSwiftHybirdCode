//
//  MVVMExampleModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/05.
//

import Foundation

struct MVVMExampleModel: Identifiable, Codable {
    
    var id = UUID()
    var name: String
    var description: String
    
    static var exampleModel = MVVMExampleModel(name: "Xbox", description: "Sample description")
    
}
