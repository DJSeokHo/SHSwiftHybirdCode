//
//  ChapterIVViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import UIKit
import SwiftUI

class ChapterIVViewController: UIViewController {

    static func start(viewController: UIViewController) {
        viewController.present(targetViewController: ChapterIVViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(ChapterIVView(
            delegate: ChapterIVDelegate(
                onFinish: {
                    self.dismiss(animated: true)
                }
            ))
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
