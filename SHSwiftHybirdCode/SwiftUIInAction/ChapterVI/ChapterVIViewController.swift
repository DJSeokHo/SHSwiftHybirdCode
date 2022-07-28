//
//  ChapterVIViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/07/16.
//

import UIKit
import SwiftUI

class ChapterVIViewController: UIViewController {

    static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: ChapterVIViewController())
    }
    
    var restaurantNames = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ChapterVIView(
                delegate: ChapterVIDelegate(
                    onFinish: {
                        self.dismiss(animated: true)
                    }
                ),
                restaurantNames: ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee", "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif", "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina", "donostia", "royaloak", "cask"]
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
