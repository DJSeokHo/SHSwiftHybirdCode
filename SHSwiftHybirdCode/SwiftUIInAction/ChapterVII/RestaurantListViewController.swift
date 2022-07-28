//
//  RestaurantListViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/21.
//

import UIKit
import SwiftUI

class RestaurantListViewController: UIViewController {

    static func start(viewController: UIViewController) {
        viewController.present(targetViewController: RestaurantListViewController(), withNavigation: true)
    }
    
    private var list = dummyData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideNavigationBar()
        
        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            RestaurantListView(
                restaurantModelList: list,
                delegate: RestaurantListDelegate(
                    onItemClick: { restaurantModel in
                        
                        RestaurantDetailViewController.start(viewController: self, restaurantModel: restaurantModel)
                        
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
