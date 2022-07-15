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
        
        let chapterIIIViewController = ChapterIIIViewController()
        chapterIIIViewController.modalPresentationStyle = .fullScreen
        viewController.present(chapterIIIViewController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUIContent(contentView:
                            UIHostingController(
                                rootView: ChapterIIIView(
                                    delegate: ChapterIIIDelegate(
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
