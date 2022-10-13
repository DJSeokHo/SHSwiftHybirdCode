//
//  ImageSimilarityCameraViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/12.
//

import UIKit
import SwiftUI
import AVFoundation
import Vision

class ImageSimilarityCameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    public static let TEST_IMAGE_SAMPLE = "https://dl.dropboxusercontent.com/s/yfo4686whj5j9n8/is_original.jpeg?dl=0"

    public static func start(viewController: UIViewController, sampleImage: String) {
        
        let imageSimilarityCameraViewController = ImageSimilarityCameraViewController()
        imageSimilarityCameraViewController.sampleImage = sampleImage
        viewController.present(targetViewController: imageSimilarityCameraViewController)
        
    }
    
    var input: AVCaptureDeviceInput? = nil
    var captureSession = AVCaptureSession()
   
    var videoDataOutput = AVCaptureVideoDataOutput()
    var preview = AVCaptureVideoPreviewLayer()
    
    private var sampleImage = ""
    private var sampleUIImage: UIImage? = nil
    
    private let viewModel = ImageSimilarityCameraViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSwiftUI(anyViewWrapper: AnyView(
            ImageSimilarityCameraView(
                delegate: ImageSimilarityCameraViewDelegate(
                    onFinish: {
                        self.dismiss(animated: true)
                    },
                    onCheckPermission: {
                        self.checkPermission()
                    },
                    onAddPreview: {
                        return self.preview
                    }
                ),
                viewModel: viewModel
            )
        ))
        
        viewModel.sampleImage = sampleImage
        
        ImageUtility.loadUrl(urlString: sampleImage, onSuccess: { uiImage in
            
            self.sampleUIImage = uiImage
        })
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
                
                if self.captureSession.canAddOutput(videoDataOutput) {
                    self.captureSession.addOutput(videoDataOutput)
                }
                
                self.captureSession.commitConfiguration()
                
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
     need AVCaptureVideoDataOutputSampleBufferDelegate
     */
    func processingVideoDataOutput() {
        self.videoDataOutput.alwaysDiscardsLateVideoFrames = true
        self.videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String : Int(kCVPixelFormatType_32BGRA)]
        self.videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "processingVideoDataOutput"))
        
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

//        ILog.debug(tag: #file, content: "captureOutput")
        
        var similarity: Float = 0
        
        if let imageSource = sampleUIImage {
            
            if let imageTarget = self.viewModel.cameraImage {
              
                similarity = compareImages(imageSource: imageSource, imageTarget: imageTarget)
                ILog.debug(tag: #file, content: "similarity \(similarity)")
                
            }
        }
        
        ThreadUtility.startUIThread {
            
            self.viewModel.cameraImage = self.uiImageFromSampleBuffer(sampleBuffer)
            self.viewModel.similarity = similarity
        }
        
    }
    
    private func uiImageFromSampleBuffer(_ sampleBuffer: CMSampleBuffer) -> UIImage? {
        
        if let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) {
            
            let ciImage = CIImage(cvPixelBuffer: pixelBuffer).oriented(.right)
            
//            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetHeight(pixelBuffer), height: CVPixelBufferGetWidth(pixelBuffer))
            
            let context = CIContext()
            
            if let image = context.createCGImage(ciImage, from: imageRect) {
                
                let uiImage = UIImage(cgImage: image)
//                ILog.debug(tag: #file, content: "image \(uiImage.size.width) \(uiImage.size.height)")
                
                return uiImage
            }
        }
        
        return nil
    }
    
    private func compareImages(imageSource: UIImage, imageTarget: UIImage) -> Float {
        
        var distance = Float(100)
        
        if let sourceObservation = featureprintObservationForImage(image: imageSource) {
            
            if let targetObservation = featureprintObservationForImage(image: imageTarget) {
                
                do{
                   
                    try sourceObservation.computeDistance(&distance, to: targetObservation)
                    
                }
                catch {
                    ILog.debug(tag: #file, content: error.localizedDescription)
                }
                
            }
            
        }
        
        return 100 - distance
    }
    
    private func featureprintObservationForImage(image: UIImage) -> VNFeaturePrintObservation? {
        
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNGenerateImageFeaturePrintRequest()
        
        do {
            try requestHandler.perform([request])
            return request.results?.first as? VNFeaturePrintObservation
        }
        catch {
            print("Vision error: \(error)")
            return nil
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
