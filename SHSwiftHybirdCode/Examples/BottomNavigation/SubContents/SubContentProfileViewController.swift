//
//  SubContentProfileViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/30.
//

import Foundation
import SwiftUI

class SubContentProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ContentView()
        ))
    }
    
}

private struct ContentView: View {
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Color
                .blue
                .ignoresSafeArea()
            
            
            Text("Profile is Blue")
                .foregroundColor(.white)
                .font(.system(size: 20, design: .rounded))
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
