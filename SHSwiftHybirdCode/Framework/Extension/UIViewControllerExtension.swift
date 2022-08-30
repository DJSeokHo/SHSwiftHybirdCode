//
//  UIViewControllerExtension.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import Foundation
import UIKit
import SwiftUI


extension UIViewController {
    
    func present(targetViewController: UIViewController, withNavigation: Bool = false) {
        if withNavigation {
            let navigationController = UINavigationController(rootViewController: targetViewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
        }
        else {
            targetViewController.modalPresentationStyle = .fullScreen
            self.present(targetViewController, animated: true, completion: nil)
        }
    }
    
    func push(targetViewController: UIViewController) {
        navigationController?.pushViewController(targetViewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func setSwiftUI(anyViewWrapper: AnyView) {
        
        let viewController = UIHostingController(rootView: anyViewWrapper)
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
