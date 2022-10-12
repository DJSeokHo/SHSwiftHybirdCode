//
//  CustomCameraTestViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/09.
//

import UIKit
import SwiftUI
import AVFoundation

class CustomCameraTestViewController: UIViewController, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: CustomCameraTestViewController())
    }
    
    var input: AVCaptureDeviceInput? = nil
    var captureSession = AVCaptureSession()
    var photoOutput = AVCapturePhotoOutput()
    var metadataOutput = AVCaptureMetadataOutput()
    var videoDataOutput = AVCaptureVideoDataOutput()
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
                },
                onCapture: {
                    self.takePhotoOutput()
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
                
                if self.captureSession.canAddOutput(photoOutput) {
                    self.captureSession.addOutput(photoOutput)
                }
                
                if self.captureSession.canAddOutput(metadataOutput) {
                    self.captureSession.addOutput(metadataOutput)
                }

                if self.captureSession.canAddOutput(videoDataOutput) {
                    self.captureSession.addOutput(videoDataOutput)
                }
                
                self.captureSession.commitConfiguration()
                
                // metadata output
                self.processingMetadataOutput()
                
                // video data output
                self.processingVideoDataOutput()
                
                ThreadUtility.startThread {
                    // start session
                    self.captureSession.startRunning()
                    // stop session
//                    self.captureSession.stopRunning()
                }
            }
        }
        catch {
            ILog.debug(tag: #file, content: error.localizedDescription)
        }
    }
    
    /**
     need AVCapturePhotoCaptureDelegate
     */
    func takePhotoOutput() {
        self.photoOutput.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
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
    
    /**
     need AVCaptureVideoDataOutputSampleBufferDelegate
     */
    func processingVideoDataOutput() {
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "processingVideoDataOutput"))
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        ILog.debug(tag: #file, content: "AVCaptureOutput ???")
        
//        guard let videoPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer), let _ = CMSampleBufferGetFormatDescription(sampleBuffer) else {
//            return
//        }
//
//        let comicEffect = CIFilter(name: "CIComicEffect")
//        let cameraImage = CIImage(cvImageBuffer: videoPixelBuffer)
//
//        comicEffect!.setValue(cameraImage, forKey: kCIInputImageKey)

//        let cgImage = self.context.createCGImage(comicEffect!.outputImage!, from: cameraImage.extent)!
//
//        DispatchQueue.main.async {
//            let filteredImage = UIImage(cgImage: cgImage)
//            self.imageView.image = filteredImage
//        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        ILog.debug(tag: #file, content: "AVCaptureMetadataOutput ???")
        
        if (metadataObjects.count > 0) {
            
            if let metadataObject = metadataObjects.first {
                let object = metadataObject as! AVMetadataMachineReadableCodeObject
                ILog.debug(tag: #file, content: String(describing: object.stringValue))
            }
          
        }

    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        ThreadUtility.startThread {
            
            ILog.debug(tag: #file, content: "AVCapturePhotoOutput ???")
            
            if error != nil {
                ILog.debug(tag: #file, content: error?.localizedDescription ?? "error")
                return
            }

            guard let photoData = photo.fileDataRepresentation() else {
                return
            }

            if let photo = UIImage(data: photoData) {
                
                UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
                ILog.debug(tag: #file, content: "photo saved")
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
