//
//  SubContentHomeViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/30.
//

import Foundation
import SwiftUI

class SubContentHomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ContentView()
        ))
    }
    
}

private struct ContentView: View {
    
    @State
    private var count = 0
    
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Color
                .red
                .ignoresSafeArea()
            
            VStack {
                
                Text("Home is Red")
                    .foregroundColor(.white)
                    .font(.system(size: 20, design: .rounded))
                
                Spacer()
                    .frame(height: 80)
                
                Text("count is \(count)")
                    .foregroundColor(.white)
                    .font(.system(size: 20, design: .rounded))
                
                Button(action: {
                    
                    count += 1
                    
                }, label: {
                    
                    Text("+")
                        .foregroundColor(.white)
                        .font(.system(size: 20, design: .rounded))
                    
                })
            }
            .frame(maxWidth: .infinity)
          
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}
