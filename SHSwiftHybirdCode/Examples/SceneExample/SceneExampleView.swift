//
//  SceneExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/18.
//

import SwiftUI
import SceneKit

struct SceneExampleView: View {
    
    var sceneKitViewController: SceneKitViewController
    
    var body: some View {
       
        ZStack {
            
            Color
                .black
                .ignoresSafeArea()
            
            Text("test test\ntest test")
                .frame(width: 300, height: 300)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.white)
            
            SceneKitView(sceneKitViewController: sceneKitViewController)
                .ignoresSafeArea(.all, edges: .all)
            
        }
        .ignoresSafeArea(.all, edges: .all)
        
    }
    
}


struct SceneKitView: UIViewControllerRepresentable {
    
    var sceneKitViewController: SceneKitViewController
    
    func makeUIViewController(context: Context) -> SceneKitViewController {
        
        return sceneKitViewController
    }
    
    func updateUIViewController(_ uiViewController: SceneKitViewController, context: Context) {
        
    }
}
