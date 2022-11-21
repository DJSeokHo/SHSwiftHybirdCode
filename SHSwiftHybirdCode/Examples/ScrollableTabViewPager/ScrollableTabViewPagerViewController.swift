//
//  ScrollableTabViewPagerViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import UIKit
import SwiftUI

class ScrollableTabViewPagerViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        let scrollableTabViewPagerViewController = ScrollableTabViewPagerViewController()
        viewController.present(targetViewController: scrollableTabViewPagerViewController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideNavigationBar()
        
        setSwiftUI(anyViewWrapper: AnyView(
            ScrollableTabViewPagerView()
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
