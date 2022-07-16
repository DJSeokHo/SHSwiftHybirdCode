//
//  MainViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/15.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUIContent(
            contentView: UIHostingController(
                rootView: MainView(
                    onButtonClick: { buttonContent in
                        
                        switch (buttonContent) {
                            
                        case "Chapter 3":
                            
                            ChapterIIIViewController.start(viewController: self)
                            
                            break
                            
                        case "Chapter 4":
                            
                            ChapterIVViewController.start(viewController: self)
                            
                            break
                            
                        case "Chapter 4 HW":
                            
                            ChapterIVHomeworkViewController.start(viewController: self)
                            
                            break
                            
                        default:
                            break
                        }
                        
                    }
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
