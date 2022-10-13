//
//  ImageSimilarityCameraView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/12.
//

import SwiftUI
import AVFoundation

struct ImageSimilarityCameraViewDelegate {
    
    var onFinish: () -> Void
    var onCheckPermission: () -> Void
    var onAddPreview: () -> AVCaptureVideoPreviewLayer
    
}

struct ImageSimilarityCameraView: View {
    
    var delegate: ImageSimilarityCameraViewDelegate
    
    @ObservedObject
    var viewModel: ImageSimilarityCameraViewModel
    
    var body: some View {
        CameraView(delegate: delegate, viewModel: viewModel)
    }
}

private struct CameraView: View {
    
    var delegate: ImageSimilarityCameraViewDelegate
    
    @ObservedObject
    var viewModel: ImageSimilarityCameraViewModel
    
    var body: some View {
        
        ZStack {
            
            // camera preview
            Color
                .black
                .ignoresSafeArea(.all, edges: .all)
            
            CameraPreviewView(preview: delegate.onAddPreview())
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(alignment: .trailing) {

                Spacer()

                HStack(alignment: .center) {
                    
                    Spacer()
                    
                    if let url = URL(string: viewModel.sampleImage) {
                        
                        AsyncImage(
                            url: url,
                            content: { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 160)
                            },
                            placeholder: {
                                
                            }
                        )
                
                    }
                    
                    Text("\(Int(viewModel.similarity))%")
                        .foregroundColor(.white)
                        .font(.system(size: 12, design: .rounded))
                    
                    if let uiImage = viewModel.cameraImage {
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                            .border(.black, width: 4)
                        
                    }
                    
                    Spacer()
                        .frame(width: 10)
                }
               
                Spacer()
                    .frame(height: 10)

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

struct ImageSimilarityCameraView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        ImageSimilarityCameraView(
            delegate: ImageSimilarityCameraViewDelegate(
                onFinish: {
                    
                },
                onCheckPermission: {
                    
                },
                onAddPreview: {
                    return AVCaptureVideoPreviewLayer()
                }
            ), viewModel: ImageSimilarityCameraViewModel()
        )
        
    }
}
