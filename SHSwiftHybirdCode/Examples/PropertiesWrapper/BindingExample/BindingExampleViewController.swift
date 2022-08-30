//
//  BindingExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/29.
//

import UIKit
import SwiftUI

class BindingExampleViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: BindingExampleViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSwiftUI(anyViewWrapper: AnyView(
            BindingExampleView()
        ))
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


private struct BindingExampleView: View {
    
    @State
    private var number = 0
    
    var body: some View {
        
        ZStack {
            
            Color
                .white
                .ignoresSafeArea()
            
            VStack {
                
                Text("\(number)")
                    .foregroundColor(.black)
                
                Spacer()
                    .frame(height: 20)
                
                Button(action: {
                    
                    number += 1
                    
                }, label: {
                    
                    Text("+")
                        .foregroundColor(.black)
                })
                
                Spacer()
                    .frame(height: 20)
                
                BindingExampleSubView(number: $number)
                
            }
            
          
        }
    }
}

private struct BindingExampleSubView: View {
    
    @Binding
    var number: Int
    
    var body: some View {
        
        Text("\(number)")
            .foregroundColor(.black)
        
    }
}
