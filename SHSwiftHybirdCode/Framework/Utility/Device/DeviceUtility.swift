//
//  DeviceUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/22.
//

import Foundation
import UIKit

class DeviceUtility {
    
    public static func isNotchScreen() -> Bool {
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        
        let isNotchScreen = window?.safeAreaInsets.bottom ?? 0 > 0
        return isNotchScreen
    }
    
}
