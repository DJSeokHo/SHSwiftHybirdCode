//
//  StateObjectAndObservedObjectExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/07.
//

import UIKit
import SwiftUI

class StateObjectAndObservedObjectExampleViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: StateObjectAndObservedObjectExampleViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
//            Test1()
            Test2()
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
