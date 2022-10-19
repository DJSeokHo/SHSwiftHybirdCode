//
//  ARExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/14.
//

import SwiftUI

struct ARExampleViewDelegate {
    var onFinish: () -> Void
}

struct ARExampleView: View {
    
    @ObservedObject
    var viewModel: ARExampleViewModel
    
    var delegate: ARExampleViewDelegate
    
    var arViewController: ARViewController
    
    var body: some View {
        
        ZStack {
            
            Color
                .black
                .ignoresSafeArea()
            
            ARView(
                arViewController: arViewController
            )
            .ignoresSafeArea(.all, edges: .all)
            
            controller
            
        }
        .ignoresSafeArea(.all, edges: .all)
    }
    
    var controller: some View {
        
        VStack {
            
            Text(viewModel.trackingState)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .font(.system(size: 14, design: .rounded))
                .padding()
                .background(Color.black.opacity(0.3))
            
            Spacer()
            
            Button(action: {
                
                arViewController.resetARSession()
                
            }, label: {
                
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 14, design: .rounded))
                    .padding()
                    .background(Color.gray)
                    .padding(.horizontal, 20)
                
                
            })
            .padding(.bottom, 60)
        }
        .padding(.top, 70)
    }
}


struct ARView: UIViewControllerRepresentable {

    var arViewController: ARViewController
    
    func makeUIViewController(context: Context) -> ARViewController {
        return arViewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: UIViewControllerRepresentableContext<ARView>) {
        ILog.debug(tag: #file, content: "updateUIViewController")
    }
}


struct ARExampleView_Previews: PreviewProvider {
    
    static var previews: some View {
        ARExampleView(
            viewModel: ARExampleViewModel(),
            delegate: ARExampleViewDelegate(
                onFinish: {
                        
                }
            ),
            arViewController: ARViewController()
        )
    }
}

