//
//  StateExampleViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/29.
//

import UIKit
import SwiftUI

class StateExampleViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: StateExampleViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setSwiftUI(anyViewWrapper: AnyView(
            StateExampleView()
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

private struct StateExampleView: View {
    
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
                
            }
            
          
        }
    }
}
