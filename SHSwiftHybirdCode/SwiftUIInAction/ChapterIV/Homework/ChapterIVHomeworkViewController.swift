//
//  ChapterIVHomeworkViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/16.
//

import UIKit
import SwiftUI

class ChapterIVHomeworkViewController: UIViewController {

    static func start(viewController: UIViewController) {
        viewController.present(targetViewController: ChapterIVHomeworkViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ChapterIVHomeworkView(
                delegate: ChapterIVHomeworkDelegate(
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
