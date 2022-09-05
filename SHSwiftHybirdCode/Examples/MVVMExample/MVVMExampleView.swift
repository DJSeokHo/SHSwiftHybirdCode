//
//  MVVMExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/09/05.
//

import SwiftUI

struct MVVMExampleView: View {
    
    @StateObject
    private var viewModel = MVVMExampleViewModel()
    
    var body: some View {
        
        VStack {
            
            Toggle("Toggle Switch", isOn: $viewModel.isTurnOn)
                .padding()
            
            HStack {
                
                Button("Increment") {
                    viewModel.increment()
                }
                
                Text("\(viewModel.counter)")
                    .bold()
                    .foregroundColor(.gray)
                    .padding()
            }
            
            List(viewModel.itemList) { item in
                
                HStack {
                    
                    Text(item.name)
                    Spacer()
                    Text(item.description)
                    
                }
                
            }
            .listStyle(.plain)
            
            Button(action: {
                
                viewModel.addItem()
                
            }, label: {
                
                Text("Add item")
            })
            .padding()
        }
    }
}

struct MVVMExampleView_Previews: PreviewProvider {
    static var previews: some View {
        MVVMExampleView()
    }
}
