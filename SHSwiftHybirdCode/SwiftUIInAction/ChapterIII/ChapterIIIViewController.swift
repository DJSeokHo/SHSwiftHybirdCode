//
//  ChapterIIIViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import UIKit
import SwiftUI

class ChapterIIIViewController: UIViewController {

    static func start(viewController: UIViewController) {
    
        viewController.present(targetViewController: ChapterIIIViewController())
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ILog.debug(tag: #file, content: DeviceUtility.isNotchScreen())
        
        hideNavigationBar()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ChapterIIIView(
                delegate: ChapterIIIDelegate(
                    onFinish: {
                        self.dismiss(animated: true)
                    }
                )
            )
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
