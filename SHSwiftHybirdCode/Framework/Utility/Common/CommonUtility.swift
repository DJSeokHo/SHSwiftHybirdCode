//
//  CommonUtility.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/22.
//

import Foundation
import UIKit
import SafariServices

class CommonUtility {
    
    public static func scrollBounces(toggle: Bool) {
        
        UIScrollView.appearance().bounces = toggle
    }
    
    public static func browser(urlString: String) {
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in })
        }
    }
    
    public static func browserInApp(urlString: String, viewController: UIViewController) {
        
        if let url = URL(string: urlString) {
            
            let safariVC = SFSafariViewController(url: url)
            viewController.present(safariVC, animated: true, completion: nil)
            
        }
    }
    
    public static func openGoogleMap(latTarget: Double, lngTarget: Double, latFrom: Double = 0, lngFrom: Double = 0) {
    
        if latFrom == 0 && lngFrom == 0 {
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
                
                // Open in app
                if let url = URL(string: "comgooglemaps://?center=\(latTarget),\(lngTarget)&zoom=14") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            else {
             
                // Open in browser
                if let urlDestination = URL.init(string: "https://www.google.com/maps/@\(latTarget),\(lngTarget),14z") {
                   UIApplication.shared.open(urlDestination)
                }
                
            }
        }
        else {
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
                
                // Open in app
                if let url = URL(string: "comgooglemaps://?saddr=\(latFrom),\(lngFrom)&daddr=\(latTarget),\(lngTarget)&directionsmode=driving") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            else {
             
                // Open in browser
                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=\(latFrom),\(lngFrom)&daddr=\(latTarget),\(lngTarget)&directionsmode=driving") {
                   UIApplication.shared.open(urlDestination)
                }
                
            }
        }
       
    }
}
