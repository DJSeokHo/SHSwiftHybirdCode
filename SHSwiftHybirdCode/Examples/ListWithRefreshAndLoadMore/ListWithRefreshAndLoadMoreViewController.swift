//
//  ListWithRefreshAndLoadMoreViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/11/21.
//

import UIKit
import SwiftUI


class ListWithRefreshAndLoadMoreViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        let listWithRefreshAndLoadMoreViewController = ListWithRefreshAndLoadMoreViewController()
        viewController.present(targetViewController: listWithRefreshAndLoadMoreViewController)
    }
    
    private let viewModel = ListWithRefreshAndLoadMoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        hideNavigationBar()
        
        setSwiftUI(anyViewWrapper: AnyView(
            ListWithRefreshAndLoadMoreView(
                viewModel: viewModel,
                delegate: ListWithRefreshAndLoadMoreDelegate(
                    
                    onReload: {
                        self.viewModel.reload()
                    },
                    
                    onLoadMore: {
                        self.viewModel.loadMore()
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
