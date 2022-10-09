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
        setSwiftUI(anyViewWrapper: AnyView(MainView(
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
                            
                        case "Chapter 6":
                            
                            ChapterVIViewController.start(viewController: self)
                            
                            break
                            
                        case "Chapter 7":
                            
                            RestaurantListViewController.start(viewController: self)
                            
                            break
                        
                        case "Chapter 20":
                            
                            ChapterXXViewController.start(viewController: self)
                            
                        default:
                            break
                        }
                        
                    }
                )
            )
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        RestaurantListViewController.start(viewController: self)
//        ChapterXXViewController.start(viewController: self)
//        PressAbleButtonViewController.start(viewController: self)
        
//        JSONEncodeDecodeViewController.start(viewController: self)
//        FoundationViewController.start(viewController: self)
//        StateExampleViewController.start(viewController: self)
//        BindingExampleViewController.start(viewController: self)
//        EnvironmentObjectExampleAViewController.start(viewController: self)
        
//        MVVMExampleViewController.start(viewController: self)
//        BottomNavigationExampleViewController.start(viewController: self)
//        CustomCameraExampleViewController.start(viewController: self)
        CustomCameraTestViewController.start(viewController: self)
        
//        SwiftUIBasicViewController.start(viewController: self)
        
//        ImageSimilarityViewController.start(viewController: self)
        
//        StateObjectAndObservedObjectExampleViewController.start(viewController: self)
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
