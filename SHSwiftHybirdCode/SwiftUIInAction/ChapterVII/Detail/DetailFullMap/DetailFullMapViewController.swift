//
//  DetailFullMapViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/01.
//

import UIKit
import SwiftUI

class DetailFullMapViewController: UIViewController {

    static func start(viewController: UIViewController, name: String, location: String) {
        
        let detailFullMapViewController = DetailFullMapViewController()
        detailFullMapViewController.name = name
        detailFullMapViewController.location = location
        viewController.push(targetViewController: detailFullMapViewController)
    }
    
    var name: String = ""
    var location: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideNavigationBar()
        
        setSwiftUI(anyViewWrapper: AnyView(
            DetailFullMapView(
                delegate: DetailFullMapDelegate(
                    onBackClick: {
                        self.pop()
                    }
                ),
                name: name,
                location: location
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
