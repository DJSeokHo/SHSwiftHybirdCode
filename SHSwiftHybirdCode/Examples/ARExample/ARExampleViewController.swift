//
//  ARExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/13.
//

import UIKit
import AVFoundation
import SwiftUI
import SceneKit
import ARKit

class ARExampleViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        let arExampleViewController = ARExampleViewController()
        viewController.present(targetViewController: arExampleViewController)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ARExampleView(delegate: ARExampleViewDelegate(
                onFinish: {
                    self.dismiss(animated: true)
                },
                onCheckPermission: {
                    self.checkPermission()
                }
            ))
        ))
    }
    
    private func checkPermission() {
        
        ILog.debug(tag: #file, content: "checkPermission")
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
            case .authorized:
                
                self.initAR()
                return
                
            case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { status in
                
                if status {
                    self.initAR()
                }
            })
            
            case .denied:
               
                return
            
            default:
                return
        }
    }
    
    private func initAR() {
        
        
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
