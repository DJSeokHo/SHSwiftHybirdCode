//
//  ImageUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/13.
//

import Foundation
import UIKit

class ImageUtility {
    
    public static func loadUrl(urlString: String, onSuccess: @escaping (_ image: UIImage) -> Void) {
        
        ThreadUtility.startThread {
            
            if let url = URL(string: urlString) {
                
                if let data = try? Data(contentsOf: url) {
                    
                    if let image = UIImage(data: data) {
                        
                        ThreadUtility.startUIThread(runnable: {
                            
                            onSuccess(image)

                        }, afterSeconds: 0)
                    
                    }
                }
                
            }
        }
    }
    
}
