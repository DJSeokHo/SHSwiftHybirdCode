//
//  ARExampleView.swift
//  SHSwiftHybirdCode
//
//  Created by mac on 2022/10/14.
//

import SwiftUI

struct ARExampleViewDelegate {
    var onFinish: () -> Void
    var onCheckPermission: () -> Void
}

struct ARExampleView: View {
    
    var delegate: ARExampleViewDelegate
    
    var body: some View {
        
        ZStack {
            
            Color
                .black
                .ignoresSafeArea()
            
            ARView()
                .ignoresSafeArea(.all, edges: .all)
            
            controller
            
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear(perform: {
            
            delegate.onCheckPermission()
            
        })
    }
    
    var controller: some View {
        
        VStack {
            
            HStack {
                
                Button(action: {
                    
                }, label: {
                    
                    Text("Style")
                        .foregroundColor(.white)
                        .font(.system(size: 14, design: .rounded))
                        .padding()
                        .background(Color.gray)
                    
                })
                .padding(.leading, 20)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    
                    Text("Reset")
                        .foregroundColor(.white)
                        .font(.system(size: 14, design: .rounded))
                        .padding()
                        .background(Color.gray)
                    
                })
                .padding(.trailing, 20)
            }
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                
                Text("Reset")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .font(.system(size: 14, design: .rounded))
                    .padding()
                    .background(Color.gray)
                    .padding(.horizontal, 20)
                
                
            })
            .padding(.bottom, 60)
        }
        .padding(.top, 70)
    }
}


struct ARView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> ARViewController {
        return ARViewController()
    }
    
    func updateUIViewController(_ uiViewController: ARView.UIViewControllerType, context: UIViewControllerRepresentableContext<ARView>) {
        
    }
}


struct ARExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ARExampleView(delegate: ARExampleViewDelegate(
            onFinish: {
                
            },onCheckPermission: {
                
            })
        )
    }
}

