//
//  QRCameraViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/12.
//

import UIKit
import SwiftUI
import AVFoundation

class QRCameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    public static func start(viewController: UIViewController, tag: String) {
        
        let qrCameraViewController = QRCameraViewController()
        qrCameraViewController.tag = tag
        viewController.present(targetViewController: qrCameraViewController)
        
    }
    
    private var input: AVCaptureDeviceInput? = nil
    private var captureSession = AVCaptureSession()
    private var metadataOutput = AVCaptureMetadataOutput()
    private var preview = AVCaptureVideoPreviewLayer()
    
    private var tag = ""
    
    private let viewModel = QRCameraViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            QRCameraView(delegate: QRCameraViewDelegate(
                onFinish: {
                    self.dismiss(animated: true)
                },
                onCheckPermission: {
                    self.checkPermission()
                },
                onAddPreview: {
                    return self.preview
                }
            ), viewModel: viewModel)
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
                return
            
            case .denied:
                return
            
            default:
                return
        }
    }
    
    private func initCamera() {
        
        do {
            
            if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
               
                // input
                input = try AVCaptureDeviceInput(device: device)
                
                guard input != nil else {
                    return
                }
                
                self.preview.session = self.captureSession
                self.captureSession.beginConfiguration()
                
               
                if self.captureSession.canAddInput(input!) {
                    self.captureSession.addInput(input!)
                }
                
                if self.captureSession.canAddOutput(metadataOutput) {
                    self.captureSession.addOutput(metadataOutput)
                }

                self.captureSession.commitConfiguration()
                
                // metadata output
                self.processingMetadataOutput()
                
                ThreadUtility.startThread {
                    
                    self.captureSession.startRunning()

                }
            }
        }
        catch {
            ILog.debug(tag: #file, content: error.localizedDescription)
        }
    }
    
    /**
     need AVCaptureMetadataOutputObjectsDelegate
     */
    func processingMetadataOutput() {
        self.metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue(label: "processingMetadataOutput"))
        self.metadataOutput.metadataObjectTypes = [
            .qr
        ]
        self.metadataOutput.rectOfInterest = CGRectMake(0, 0, 1, 1)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if (metadataObjects.count > 0) {
            
            if let metadataObject = metadataObjects.first {
                let object = metadataObject as! AVMetadataMachineReadableCodeObject
                if let result = object.stringValue {
                    ILog.debug(tag: #file, content: result)
                    
                    self.captureSession.stopRunning()
                    
                    var data: [String: Any] = [:]
                    data["qr"] = result
                    data["tag"] = self.tag
                    
                    ThreadUtility.startUIThread(runnable: {
                        
                        ILog.debug(tag: #file, content: "scan finished \(data)")
                        
                        self.viewModel.scanLine = false
                        
                        NotificationUtility.post(name: NotificationConstants.SCAN_QR_RESULT, userInfo: data)
                        
                        self.dismiss(animated: true)
                        
                    }, afterSeconds: 0)
                }
            }
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
