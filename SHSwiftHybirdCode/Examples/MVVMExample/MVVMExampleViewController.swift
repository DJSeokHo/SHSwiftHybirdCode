//
//  MVVMExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/05.
//

import UIKit
import SwiftUI

class MVVMExampleViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: MVVMExampleViewController())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            MVVMExampleView()
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
