//
//  ListWithRefreshAndLoadMoreViewModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import Foundation
import SwiftUI

class ListWithRefreshAndLoadMoreViewModel: ObservableObject {
    
    @Published
    var list: [TestItemModel] = []
    
    @Published
    var loading = false
    
    func reload() {
        
        ILog.debug(tag: #file, content: "reload")
        
        loading = true
        
        Task {
            
            try await Task.sleep(nanoseconds: 2_000_000_000)
            
            let tempList = await ListWithRefreshAndLoadMoreService.generator(offset: 0, limit: 20)
            
            DispatchQueue.main.async {
                
                self.loading = false
                
                self.list.removeAll()
                self.list.append(contentsOf: tempList)
                
            }
        }
        
    }
    
    func loadMore() {
        
        ILog.debug(tag: #file, content: "loadMore")
        
        loading = true
        
        Task {
            
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            let tempList = await ListWithRefreshAndLoadMoreService.generator(offset: list.count, limit: 10)
            
            DispatchQueue.main.async {
                
                self.loading = false
                
                self.list.append(contentsOf: tempList)
                
            }
        }
        
    }
    
}

class ListWithRefreshAndLoadMoreService {
    
    
    static func generator(offset: Int, limit: Int) async -> [TestItemModel] {
        
        var list: [TestItemModel] = []
        
        var testItemModel: TestItemModel
        
        for i in offset..<(offset + limit) {
            
            testItemModel = TestItemModel()
            testItemModel.index = i
            testItemModel.title = "title \(i)"
            testItemModel.content = "content \(i)"
            
            list.append(testItemModel)
        }
        
        return list
    }
}

struct TestItemModel: Identifiable {
    
    var id = UUID()
    var index = 0
    var title = ""
    var content = ""
    
}
