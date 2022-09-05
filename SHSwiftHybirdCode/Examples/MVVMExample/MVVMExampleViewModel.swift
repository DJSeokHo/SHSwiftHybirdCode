//
//  MVVMExampleViewModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/05.
//

import Foundation
import SwiftUI

class MVVMExampleViewModel: ObservableObject {
    
    @Published
    var isTurnOn: Bool = false
    
    @Published
    var counter = 0
    
    @Published
    var itemList = [MVVMExampleModel]()
    
    func increment() {
        counter += 1
    }
    
    func addItem() {
        
        let randomItems = ["Playstation", "XBox", "Nintendo Wii", "Game"]
        let item = randomItems.randomElement()
        
        let newItem = MVVMExampleModel(name: item!, description: "Item: \(itemList.count + 1)")
    
        withAnimation {
            itemList.insert(newItem, at: 0)
        }
    }
    
}
