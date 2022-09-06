//
//  CustomCameraExampleViewModel.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/06.
//

import Foundation
import SwiftUI
import AVFoundation

/**
 AVFoundation 框架基于以下几个类实现图像捕捉 ，通过这些类可以访问来自相机设备的原始数据并控制它的组件:
 AVCaptureDevice 是关于相机硬件的接口。它被用于控制硬件特性，诸如镜头的位置、曝光、闪光灯等。
 AVCaptureDeviceInput 提供来自设备的数据。
 AVCaptureOutput 是一个抽象类，描述 capture session 的结果。以下是三种关于静态图片捕捉的具体子类：
 AVCaptureStillImageOutput 用于捕捉静态图片
 AVCaptureMetadataOutput 启用检测人脸和二维码
 AVCaptureVideoOutput 为实时预览图提供原始帧
 AVCaptureSession 管理输入与输出之间的数据流，以及在出现问题时生成运行时错误。
 AVCaptureVideoPreviewLayer 是 CALayer 的子类，可被用于自动显示相机产生的实时图像。它还有几个工具性质的方法，可将 layer 上的坐标转化到设备上。它看起来像输出，但其实不是。另外，它拥有 session (outputs 被 session 所拥有)。
 */
class CustomCameraExampleViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    @Published
    var isTaken = false
    
    // 管理输入与输出之间的数据流，以及在出现问题时生成运行时错误。
    @Published
    var captureSession = AVCaptureSession()
    
    @Published
    var alert = false
    
    @Published
    var output = AVCapturePhotoOutput()
    
    @Published
    var preview: AVCaptureVideoPreviewLayer!
    
    @Published
    var isPhotoSaved = false
    
    @Published
    var photoData = Data(count: 0)
    
    func checkPermission() {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
            case .authorized:
                
                setUpCamera()
                return
                
            case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { status in
                
                if status {
                    self.setUpCamera()
                }
            })
            
            case .denied:
                self.alert.toggle()
                return
            
            default:
                return
        }
    
    }
    
    private func setUpCamera() {
        
        do {
            
            if let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) {
                
                self.captureSession.beginConfiguration()
                
                let input = try AVCaptureDeviceInput(device: device)
                
                if self.captureSession.canAddInput(input) {
                    self.captureSession.addInput(input)
                }
                
                if self.captureSession.canAddOutput(output) {
                    self.captureSession.addOutput(output)
                }
                
                self.captureSession.commitConfiguration()
            }
        }
        catch {
            ILog.debug(tag: #file, content: error.localizedDescription)
        }
    }
    
    func takePhoto() {
        
        ThreadUtility.startThread {
            
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.captureSession.stopRunning()
            
            ThreadUtility.startUIThread(runnable: {
                
                withAnimation {
                    self.isTaken.toggle()
                }
                
                self.isPhotoSaved = false
                
            }, afterSeconds: 0)
        }
    }
    
    func retake() {
        
        ThreadUtility.startThread {
            
            self.captureSession.startRunning()
            
            ThreadUtility.startUIThread(runnable: {
                
                withAnimation {
                    self.isTaken.toggle()
                }
                
            }, afterSeconds: 0)
        }
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if error != nil {
            ILog.debug(tag: #file, content: error?.localizedDescription ?? "error")
            return
        }
        
        guard let photoData = photo.fileDataRepresentation() else {
            return
        }
        
        self.photoData = photoData
    }
    
    func savePhoto() {
        
        if let photo = UIImage(data: self.photoData) {
            
            UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
            
            self.isPhotoSaved = true
            
            ILog.debug(tag: #file, content: "photo saved")
        }
    }
}
