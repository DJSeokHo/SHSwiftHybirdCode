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
    var onCapture: () -> Void
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
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    delegate.onCapture()
                    
                }, label: {
                    
                    ZStack {
                        
                        Circle()
                            .fill(Color.white)
                            .frame(width: 65, height: 65)
                        
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                            .frame(width: 75, height: 75)
                    }
                    
                })
                
                Spacer()
                    .frame(height: 30)
                
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

struct CustomCameraTestView_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomCameraTestView(delegate: CustomCameraTestViewDelegate(
            onFinish: {
               
            },
            onCheckPermission: {
                
            },
            onAddPreview: {
                return AVCaptureVideoPreviewLayer()
            },
            onCapture: {
                
            }
        ))

    }
}