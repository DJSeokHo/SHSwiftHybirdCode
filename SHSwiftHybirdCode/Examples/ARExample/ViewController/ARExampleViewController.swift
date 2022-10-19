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
        
        ILog.debug(tag: #file, content: "checkPermission")
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
            case .authorized:
                
                let arExampleViewController = ARExampleViewController()
                viewController.present(targetViewController: arExampleViewController)
                return
                
            case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { status in
                
                if status {
                    let arExampleViewController = ARExampleViewController()
                    viewController.present(targetViewController: arExampleViewController)
                }
            })
            
            case .denied:
               
                return
            
            default:
                return
        }
    }
    
    private let viewModel = ARExampleViewModel()
    private let arViewController = ARViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arViewController.viewModel = viewModel
        
        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ARExampleView(
                viewModel: viewModel,
                delegate: ARExampleViewDelegate(
                    onFinish: {
                        self.dismiss(animated: true)
                    }
                ),
                arViewController: arViewController
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
