//
//  SubContentFavoriteViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/30.
//

import Foundation
import SwiftUI

struct SubContentFavoriteViewControllerSwiftUI: UIViewControllerRepresentable {
    
    @Binding
    var count: Int
    
    var onPlus: () -> Void

    var subContentFavoriteViewController: SubContentFavoriteViewController
    
//    func makeCoordinator() -> Coordinator {
//        ILog.debug(tag: #file, content: "makeCoordinator")
//    }
    
    func makeUIViewController(context: Context) -> SubContentFavoriteViewController {
        ILog.debug(tag: #file, content: "makeUIViewController \(count)")
        subContentFavoriteViewController.count = count
        subContentFavoriteViewController.onPlus = onPlus
        
        return subContentFavoriteViewController
    }
    
    func updateUIViewController(_ subContentFavoriteViewController: SubContentFavoriteViewController, context: Context) {
        ILog.debug(tag: #file, content: "updateUIViewController \(count)")
        subContentFavoriteViewController.count = count
        
        subContentFavoriteViewController.updateView(anyViewWrapper: AnyView(
            ContentView(count: count, onPlus: {
                self.onPlus()
            })
        ))
      
    }
    
//    static func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: ()) {
//        ILog.debug(tag: #file, content: "dismantleUIViewController")
//    }
    
}


class SubContentFavoriteViewController: UIViewController {
    
    var count: Int = 0
    var onPlus: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ContentView(count: count, onPlus: {
                self.onPlus?()
            })
        ))
    }
    
    func updateView(anyViewWrapper: AnyView) {
        setSwiftUI(anyViewWrapper: anyViewWrapper)
    }
    
}

private struct ContentView: View {
    
    var count: Int
    var onPlus: () -> Void
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Color
                .green
                .ignoresSafeArea()
            
            VStack {
                
                Text("Favorite is Green")
                    .foregroundColor(.white)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
                    .frame(height: 80)
                
                Text("count is \(count)")
                    .foregroundColor(.white)
                    .font(.system(size: 20, design: .rounded))
                
                Button(action: {
                    
                    onPlus()
                    
                }, label: {
                    
                    Text("+")
                        .foregroundColor(.white)
                        .font(.system(size: 20, design: .rounded))
                    
                })
            }.frame(maxWidth: .infinity)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
