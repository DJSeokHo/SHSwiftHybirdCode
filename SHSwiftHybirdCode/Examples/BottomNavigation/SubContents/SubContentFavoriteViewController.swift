//
//  SubContentFavoriteViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/30.
//

import Foundation
import SwiftUI

struct SubContentFavoriteViewControllerSwiftUI: UIViewControllerRepresentable {
    
    var subContentFavoriteViewController: SubContentFavoriteViewController
    var viewModel: SubContentFavoriteViewModel
    
//    func makeCoordinator() -> Coordinator {
//        ILog.debug(tag: #file, content: "makeCoordinator")
//    }
    
    func makeUIViewController(context: Context) -> SubContentFavoriteViewController {
        
        subContentFavoriteViewController.viewModel = viewModel
        
        return subContentFavoriteViewController
    }
    
    func updateUIViewController(_ subContentFavoriteViewController: SubContentFavoriteViewController, context: Context) {
      
    }
    
//    static func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: ()) {
//        ILog.debug(tag: #file, content: "dismantleUIViewController")
//    }
    
}


class SubContentFavoriteViewController: UIViewController {
    
    public var viewModel: SubContentFavoriteViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let viewModel = viewModel {
            setSwiftUI(anyViewWrapper: AnyView(
                ContentView(viewModel: viewModel)
            ))
        }
       
    }
    
}

private struct ContentView: View {
    
    // 用于从外部引用已经生成的viewModel对象，界面重新载入依然可以保持状态
    @ObservedObject
    var viewModel: SubContentFavoriteViewModel
    
    // 每次都会创建一个viewModel，界面重新载入的话无法保持状态
//    @StateObject
//    private var viewModel = SubContentFavoriteViewModel()
    
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
                
                Text("count is \(viewModel.count)")
                    .foregroundColor(.white)
                    .font(.system(size: 20, design: .rounded))
                
                Button(action: {
                    
                    viewModel.increment()
                    
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
