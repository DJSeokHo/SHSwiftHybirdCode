//
//  Scene3DModelExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/19.
//

import UIKit
import SwiftUI

class Scene3DModelExampleViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        let scene3DModelExampleViewController = Scene3DModelExampleViewController()
        viewController.present(targetViewController: scene3DModelExampleViewController)
    }
    
    private let scene3DModelViewController = Scene3DModelViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            Scene3DModelExampleView(scene3DModelViewController: scene3DModelViewController)
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
