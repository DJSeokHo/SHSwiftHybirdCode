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
 
 AVCaptureDeviceInput(捕捉输入):
 AVCaptureDeviceInput(捕捉设备)：它实际上是为摄像头和麦克风等物理设备定义的接口，我们可以通过它来访问或控制这些硬件设备。比如控制摄像头的对焦、曝光等。
 
 AVCaptureOutput 是一个抽象类，描述 capture session 的结果。以下是三种关于静态图片捕捉的具体子类：
 AVCaptureStillImageOutput 用于捕捉静态图片
 AVCaptureMetadataOutput 启用检测人脸和二维码
 AVCaptureVideoOutput 为实时预览图提供原始帧
 
 AVCaptureSession(捕捉会话管理):
 它从物理设备得到数据流，比如摄像头和麦克风，输出到一个或多个目的地。
 capture session 可以通过会话预设值(session preset)，来控制捕捉数据的格式和质量，下面是创建一个 session 的代码：
 session preset在iOS中大概有11个
 NSString *const AVCaptureSessionPresetPhoto;
 NSString *const AVCaptureSessionPresetHigh;
 NSString *const AVCaptureSessionPresetMedium;
 NSString *const AVCaptureSessionPresetLow;
 NSString *const AVCaptureSessionPreset352x288;
 NSString *const AVCaptureSessionPreset640x480;
 NSString *const AVCaptureSessionPreset1280x720;
 NSString *const AVCaptureSessionPreset1920x1080;
 NSString *const AVCaptureSessionPresetiFrame960x540;
 NSString *const AVCaptureSessionPresetiFrame1280x720;
 NSString *const AVCaptureSessionPresetInputPriority;

第一个代表高像素图片输出；
接下来三种为相对预设(low, medium, high)，这些预设的编码配置会因设备不同而不同，如果选择high，那么你选定的相机会提供给你该设备所能支持的最高画质；
再后面就是特定分辨率的预设(352x288 VGA, 1920x1080 VGA, 1280x720 VGA, 640x480 VGA, 960x540 iFrame, 1280x720 iFrame)；
最后一个代表 capture session 不去控制音频与视频输出设置，而是通过已连接的捕获设备的 activeFormat 来反过来控制 capture session 的输出质量等级
 
 
 AVCaptureVideoPreviewLayer(捕捉预览):
 AVCaptureVideoPreviewLayer(捕捉预览)：它是CALayer的子类，可被用于自动显示相机产生的实时图像。
 preview layer支持视频重力概念，可以控制视频内容渲染的缩放和拉效果(关于视频重力，将在后面进行详解)
 注意：
 1. 它看起来有点像输出，但其实不是，它仅用来预览摄像头捕捉的画面。真正用于输出的是AVCaptureSession（previewLayer拥有session，session拥有outputs)；
 2. 它的坐标系和屏幕的坐标系不同，如果点击某区域实现对焦时，我们需要将设备的坐标系转换为实时预览图的坐标；
 3. 它的坐标原点永远都在右上角，这和我们手机的坐标系不同，手机坐标系的原点是不变的。因此拍照或录制视频是，要先得到设备方向(关于方向问题，后面会详解)，计算输出的旋转角度。

 捕捉预览除了用AVCaptureVideoPreviewLayer外，还可以用OpenGL ES绘制，我们可以从输出数据流捕捉单一的图像帧，并使用 OpenGL ES手动地把它们显示在 view 上。如果我们想对预览视图进行操作，如使用滤镜，我们就必须这样做。
 
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
        
        ILog.debug(tag: #file, content: "photoOutput ???")
        
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
