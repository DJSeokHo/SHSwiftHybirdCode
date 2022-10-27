//
//  NaverMapViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/27.
//

import UIKit
import SwiftUI
import NMapsMap

class NaverMapViewController: UIViewController {
  
    public static func start(viewController: UIViewController) {
        
        let naverMapViewController = NaverMapViewController()
        viewController.present(targetViewController: naverMapViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSwiftUI(anyViewWrapper: AnyView(
            NaverMapView(
                delegate: NaverMapViewDelegate(
                    onFinish: {
                        self.dismiss(animated: true)
                    },
                    onInit: { naverMapView in
                        
                        NaverMapManager.instance.setup(naverMapView: naverMapView)
                       
                        LocationWrapper.instance.requestLocation({
                            
                        }, onLocateFinished: {
                            
                            NaverMapManager.instance.moveCamera(
                                naverMapView: naverMapView,
                                lat: LocationWrapper.instance.currentLocation?.coordinate.latitude ?? 0,
                                lng: LocationWrapper.instance.currentLocation?.coordinate.longitude ?? 0
                            )
                            
                            NaverMapManager.instance.selfLocation(
                                naverMapView: naverMapView,
                                lat: LocationWrapper.instance.currentLocation?.coordinate.latitude ?? 0,
                                lng: LocationWrapper.instance.currentLocation?.coordinate.longitude ?? 0
                            )
                            
                            LocationWrapper.instance.stopLocation()
                        })
                        
                    },
                    onCheckPermission: {
                        
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
