//
//  ImageSimilarityCameraViewModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/13.
//

import Foundation
import SwiftUI
import CoreMedia

class ImageSimilarityCameraViewModel: ObservableObject {
    
    @Published
    var similarity: Float = 0
    
    @Published
    var sampleImage = ""
    
    @Published
    var cameraImage: UIImage? = nil
}
