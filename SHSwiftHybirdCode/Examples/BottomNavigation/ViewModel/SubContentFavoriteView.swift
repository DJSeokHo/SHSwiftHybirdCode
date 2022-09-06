//
//  SubContentFavoriteView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/06.
//

import Foundation
import SwiftUI

class SubContentFavoriteViewModel: ObservableObject {
    
    @Published
    public var count: Int = 0
    
    func increment() {
        count += 1
    }
    
}
