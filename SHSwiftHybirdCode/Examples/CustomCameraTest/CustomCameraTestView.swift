//
//  CustomCameraTestView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/09.
//

import SwiftUI
import AVFoundation

struct CustomCameraTestViewDelegate {
    
    var onFinish: () -> Void
    var onCheckPermission: () -> Void
    var onAddPreview: () -> AVCaptureVideoPreviewLayer
}

struct CustomCameraTestView: View {
    
    var delegate: CustomCameraTestViewDelegate
    
    var body: some View {
       
        CameraView(delegate: delegate)
        
    }
}


private struct CameraView: View {
    
    var delegate: CustomCameraTestViewDelegate
    
    var body: some View {
        
        ZStack {
            
            // camera preview
            Color
                .black
                .ignoresSafeArea(.all, edges: .all)
            
            CameraPreviewView(preview: delegate.onAddPreview())
                .ignoresSafeArea(.all, edges: .all)
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
