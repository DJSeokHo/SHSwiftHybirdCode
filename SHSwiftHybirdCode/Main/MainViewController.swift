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

        initNotification()
        
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
        
        ThreadUtility.startThread {
            
            ThreadUtility.startUIThread(runnable: {
                
                
        //        RestaurantListViewController.start(viewController: self)
        //        ChapterXXViewController.start(viewController: self)
        //        PressAbleButtonViewController.start(viewController: self)
                
        //        JSONEncodeDecodeViewController.start(viewController: self)
        //        FoundationViewController.start(viewController: self)
        //        StateExampleViewController.start(viewController: self)
        //        BindingExampleViewController.start(viewController: self)
        //        EnvironmentObjectExampleAViewController.start(viewController: self)
                
        //        MVVMExampleViewController.start(viewController: self)
//                BottomNavigationExampleViewController.start(viewController: self)
//                CustomCameraTestViewController.start(viewController: self)
//                QRCameraViewController.start(viewController: self, tag: #file)
                
        //        SwiftUIBasicViewController.start(viewController: self)
                
        //        ImageSimilarityViewController.start(viewController: self)
                
//                StateObjectAndObservedObjectExampleViewController.start(viewController: self)
                
//                ImageSimilarityViewController.start(viewController: self)
                
//                ImageSimilarityCameraViewController.start(viewController: self, sampleImage: ImageSimilarityCameraViewController.TEST_IMAGE_SAMPLE)
                
//                ARExampleViewController.start(viewController: self)
//                SceneExampleViewController.start(viewController: self)
                Scene3DModelExampleViewController.start(viewController: self)
//                NaverMapViewController.start(viewController: self)
//                DrawerMenuExampleViewController.start(viewController: self)
//                ListWithRefreshAndLoadMoreViewController.start(viewController: self)
                
//                ScrollableTabViewPagerViewController.start(viewController: self)
                
            }, afterSeconds: 1)
        }
    }
    
    private func initNotification() {
        NotificationUtility.addObserver(name: NotificationConstants.SCAN_QR_RESULT, observer: self, selector: #selector(onScanQRResult))
    }
    
    deinit {
        NotificationUtility.removeAllObserver(observer: self)
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

extension MainViewController {
    
    @objc private func onScanQRResult(_ notification: Notification) {
        
        let tag = NotificationUtility.getNotificationResult(notification, key: "tag")
        let qr = NotificationUtility.getNotificationResult(notification, key: "qr")
        
        ILog.debug(tag: #file, content: "onScanQRResult")
       
        ILog.debug(tag: #file, content: tag)
        ILog.debug(tag: #file, content: qr)
        
    }
    
}
