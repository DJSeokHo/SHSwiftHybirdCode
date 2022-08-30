//
//  EnvironmentObjectExampleAViewController.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/08/29.
//

import UIKit
import SwiftUI

class EnvironmentObjectExampleAViewController: UIViewController {

    public static func start(viewController: UIViewController) {
        
        viewController.present(targetViewController: EnvironmentObjectExampleAViewController())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EnvironmentObjectExampleClassModel.instance
        
        // Do any additional setup after loading the view.
        setSwiftUI(anyViewWrapper: AnyView(
            ContentView(onOpenB: {
                EnvironmentObjectExampleBViewController.start(viewController: self)
            }).environmentObject(EnvironmentObjectExampleClassModel.instance)
        ))
        
        Task {
            
            EnvironmentObjectExampleClassModel.instance.initData(name: "This is A")
        }
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

private struct ContentView: View {
    
    @EnvironmentObject
    var model: EnvironmentObjectExampleClassModel
    
    var onOpenB: () -> Void
    
    var body: some View {
        
        ZStack {
            
            Color
                .white
                .ignoresSafeArea()
            
            VStack {
                
                Text("\(model.number)")
                    .foregroundColor(.black)
                
                Spacer()
                    .frame(height: 20)
                
                Text("\(model.name)")
                    .foregroundColor(.black)
                
                Spacer()
                    .frame(height: 20)
                
                Button(action: {
                    
                    model.number += 1
                    
                }, label: {
                    
                    Text("+")
                        .foregroundColor(.black)
                })
                
                Spacer()
                    .frame(height: 40)
                
                Button(action: {
                    
                    onOpenB()
                    
                }, label: {
                    
                    Text("open B")
                        .foregroundColor(.black)
                })
                
            }
        }
        
    }
    
}
