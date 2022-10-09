//
//  CustomCameraTestViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/09.
//

import UIKit
import SwiftUI
import AVFoundation

class CustomCameraTestViewController: UIViewController {
    
    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: CustomCameraTestViewController())
    }
    
    var captureSession = AVCaptureSession()
    var output = AVCapturePhotoOutput()
    var preview = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            CustomCameraTestView(delegate: CustomCameraTestViewDelegate(
                onFinish: {
                    self.dismiss(animated: true)
                },
                onCheckPermission: {
                    self.checkPermission()
                },
                onAddPreview: {
                    return self.preview
                }
            ))
        ))
    }
    
    private func checkPermission() {
        
        ILog.debug(tag: #file, content: "checkPermission")
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
            case .authorized:
                
                self.initCamera()
                return
                
            case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { status in
                
                if status {
                    self.initCamera()
                }
            })
            
            case .denied:
               
                return
            
            default:
                return
        }
    }
    
    private func initCamera() {
        
        do {
            
            if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                
                self.preview.session = self.captureSession
                
                self.captureSession.beginConfiguration()
                
                let input = try AVCaptureDeviceInput(device: device)
                
                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }
                
                if self.captureSession.canAddOutput(output) {
                    self.captureSession.addOutput(output)
                }
                
                self.captureSession.commitConfiguration()
                
                ThreadUtility.startThread {
                    // start session
                    self.captureSession.startRunning()
                }
               
            }
        }
        catch {
            ILog.debug(tag: #file, content: error.localizedDescription)
        }
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
