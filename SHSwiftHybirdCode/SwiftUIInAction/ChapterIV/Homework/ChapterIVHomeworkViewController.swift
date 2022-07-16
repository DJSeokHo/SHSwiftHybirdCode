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
        
        let chapterIVHomeworkViewController = ChapterIVHomeworkViewController()
        chapterIVHomeworkViewController.modalPresentationStyle = .fullScreen
        viewController.present(chapterIVHomeworkViewController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUIContent(
            contentView: UIHostingController(
                rootView: ChapterIVHomeworkView(
                    delegate: ChapterIVHomeworkDelegate(
                        onFinish: {
                            self.dismiss(animated: true)
                        }
                    )
                )
            )
        )
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
