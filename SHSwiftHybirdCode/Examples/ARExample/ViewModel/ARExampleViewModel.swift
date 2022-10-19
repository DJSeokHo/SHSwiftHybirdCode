//
//  ARExampleViewModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/17.
//

import Foundation
import SwiftUI

class ARExampleViewModel: ObservableObject {
    
    @Published
    var trackingState: String = "Tracking"
}
