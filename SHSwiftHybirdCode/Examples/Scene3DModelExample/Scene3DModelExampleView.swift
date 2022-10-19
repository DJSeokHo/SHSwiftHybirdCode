//
//  Scene3DModelExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/19.
//

import SwiftUI

struct Scene3DModelExampleView: View {
    
    var scene3DModelViewController: Scene3DModelViewController
    
    var body: some View {
       
        ZStack {
            
            Color
                .black
                .ignoresSafeArea()
            
            Scene3DModelView(scene3DModelViewController: scene3DModelViewController)
                .ignoresSafeArea(.all, edges: .all)
            
        }
        .ignoresSafeArea(.all, edges: .all)
        
    }
}

struct Scene3DModelView: UIViewControllerRepresentable {
    
    var scene3DModelViewController: Scene3DModelViewController
    
    func makeUIViewController(context: Context) -> Scene3DModelViewController {
        
        return scene3DModelViewController
    }
    
    func updateUIViewController(_ uiViewController: Scene3DModelViewController, context: Context) {
        
    }
}

struct Scene3DModelView_Previews: PreviewProvider {
    static var previews: some View {
        Scene3DModelExampleView(scene3DModelViewController: Scene3DModelViewController())
    }
}
