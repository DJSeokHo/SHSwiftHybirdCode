//
//  UIViewControllerExtension.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setSwiftUIContent(contentView: UIViewController) {
        
        addChild(contentView)
        view.addSubview(contentView.view)
        
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
}
