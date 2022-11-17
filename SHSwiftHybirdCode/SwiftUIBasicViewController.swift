//
//  SwiftUIBasicViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/13.
//

import UIKit
import SwiftUI

class SwiftUIBasicViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        viewController.present(targetViewController: SwiftUIBasicViewController())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
//            ZStackExampleView()
//            VStackExample()
//            ScrollExample()
//            VStackExample()
//            SpacerExample()
            HStackExample()
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
