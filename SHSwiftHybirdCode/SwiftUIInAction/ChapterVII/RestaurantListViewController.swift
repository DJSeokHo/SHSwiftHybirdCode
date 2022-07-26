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
        
        let restaurantListViewController = RestaurantListViewController()
        restaurantListViewController.modalPresentationStyle = .fullScreen
        viewController.present(restaurantListViewController, animated: true, completion: nil)
        
    }
    
    private var list = dummyData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUIContent(
            contentView: UIHostingController(
                rootView: RestaurantListView(restaurantModelList: list)
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
