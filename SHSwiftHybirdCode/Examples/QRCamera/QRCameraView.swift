//
//  QRCameraView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/12.
//

import SwiftUI
import AVFoundation

struct QRCameraViewDelegate {
    
    var onFinish: () -> Void
    var onCheckPermission: () -> Void
    var onAddPreview: () -> AVCaptureVideoPreviewLayer
}

struct QRCameraView: View {
    
    var delegate: QRCameraViewDelegate
    
    @ObservedObject
    var viewModel: QRCameraViewModel
    
    var body: some View {
       
        ContentView(delegate: delegate, viewModel: viewModel)
        
    }
}

private struct ContentView: View {
    
    var delegate: QRCameraViewDelegate
    
    @ObservedObject
    var viewModel: QRCameraViewModel
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            // camera preview
            Color
                .black
                .ignoresSafeArea(.all, edges: .all)
            
            CameraPreviewView(preview: delegate.onAddPreview())
                .ignoresSafeArea(.all, edges: .all)
            
            if viewModel.scanLine {
                LottieView(lottieFile: "ti_scan.json")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .padding(.horizontal, 50)
            }
           
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear(perform: {
            
            delegate.onCheckPermission()
            
        })
        
    }
}

private struct CameraPreviewView: UIViewRepresentable {
    
    var preview: AVCaptureVideoPreviewLayer
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        preview.frame = view.frame
        preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(preview)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct QRCameraView_Previews: PreviewProvider {
    static var previews: some View {
        QRCameraView(delegate: QRCameraViewDelegate(
            onFinish: {
               
            },
            onCheckPermission: {
               
            },
            onAddPreview: {
                return AVCaptureVideoPreviewLayer()
            }
        ), viewModel: QRCameraViewModel())
    }
}
