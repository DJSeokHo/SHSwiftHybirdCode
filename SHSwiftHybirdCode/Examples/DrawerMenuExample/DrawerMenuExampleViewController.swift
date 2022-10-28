//
//  DrawerMenuExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/28.
//

import UIKit
import SwiftUI

class DrawerMenuExampleViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        let drawerMenuExampleViewController = DrawerMenuExampleViewController()
        viewController.present(targetViewController: drawerMenuExampleViewController)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            DrawerMenuExampleView()
        ))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
