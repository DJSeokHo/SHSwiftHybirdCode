//
//  CustomCameraExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/06.
//

import SwiftUI
import AVFoundation

struct CustomCameraExampleView: View {
    
    @StateObject
    var viewModel: CustomCameraExampleViewModel
    
    var body: some View {
        
        CameraView(viewModel: viewModel)
        
    }
}

private struct CameraView: View {
    
    @ObservedObject
    var viewModel: CustomCameraExampleViewModel
    
    var body: some View {
        
        ZStack {
            
            // camera preview
            Color
                .black
                .ignoresSafeArea(.all, edges: .all)
            
            CameraPreviewView(viewModel: viewModel)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                if viewModel.isTaken {
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            viewModel.retake()
                            
                        }, label: {
                            
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                           
                        })
                        .padding(.trailing, 10)
                        .padding(.top, 60)
                        
                    }
                   
                }
                
                Spacer()
                
                HStack {
                    
                    if viewModel.isTaken {
                        
                        Button(action: {
                            
                            if !viewModel.isPhotoSaved {
                                viewModel.savePhoto()
                            }
                            
                        }, label: {
                            
                            Text(viewModel.isPhotoSaved ? "Saved" : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.white)
                                .clipShape(Capsule())
                           
                        })
                        .padding(.leading)
                        
                        Spacer()
                        
                    }
                    else {
                        
                        Button(action: {
                            
                            viewModel.takePhoto()
                            
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
                        
                    }
                }
                .frame(height: 75)
                
                Spacer()
                    .frame(height: 30)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear(perform: {
            
            viewModel.checkPermission()
            
        })
        
    }
}

private struct CameraPreviewView: UIViewRepresentable {
    
    @ObservedObject
    var viewModel: CustomCameraExampleViewModel
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        
        viewModel.preview = AVCaptureVideoPreviewLayer(session: viewModel.captureSession)
        
        viewModel.preview.frame = view.frame
        
        viewModel.preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(viewModel.preview)
        
        // start session
        viewModel.captureSession.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct CustomCameraExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCameraExampleView(viewModel: CustomCameraExampleViewModel())
    }
}
