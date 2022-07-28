//
//  RestaurantDetailViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/27.
//

import UIKit
import SwiftUI

class RestaurantDetailViewController: UIViewController {
    
    static func start(viewController: UIViewController, restaurantModel: RestaurantModel) {
        
        let restaurantDetailViewController = RestaurantDetailViewController()
        restaurantDetailViewController.restaurantModel = restaurantModel
        viewController.push(targetViewController: restaurantDetailViewController)
    }
    
    var restaurantModel: RestaurantModel? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        hideNavigationBar()
        
        guard restaurantModel != nil else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        setSwiftUI(anyViewWrapper: AnyView(
            RestaurantDetailView(
                restaurantModel: restaurantModel!,
                delegate: RestaurantDetailDelegate(
                    onBackClick: {
                        self.pop()
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
