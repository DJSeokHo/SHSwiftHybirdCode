//
//  SceneExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/18.
//

import UIKit
import SwiftUI

class SceneExampleViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        let sceneExampleViewController = SceneExampleViewController()
        viewController.present(targetViewController: sceneExampleViewController)
    }
    
    private let sceneKitViewController = SceneKitViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            SceneExampleView(sceneKitViewController: sceneKitViewController)
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
